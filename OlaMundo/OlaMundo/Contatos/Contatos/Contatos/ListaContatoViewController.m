//
//  ListaContatoViewController.m
//  Contatos
//
//  Created by Jossemar Avila de Morais on 31/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "ListaContatoViewController.h"
#import "FormularioContatoController.h"
#import "Contato.h"
#import <Twitter/Twitter.h>

@implementation ListaContatoViewController

@synthesize contatos;

Contato *contatoPressionado;

- (id) initWithContatos:(NSMutableArray *) listaContatos {
    self = [self init];
    
    [self setContatos: listaContatos];
    
    return self;
}


- (id)init {
    self = [super init];
    if (self) {
        UIBarButtonItem *botaoNovo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
        
        [[self navigationItem] setTitle:NSLocalizedString(@"titulo_listagem", nil)];
        [[self navigationItem] setRightBarButtonItem:botaoNovo];        
    }
    return self;
}


- (void) exibeFormulario {
    FormularioContatoController *formulario = [[FormularioContatoController alloc] initWithDelegate:self andContato:nil];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:formulario];
    
    [self presentModalViewController:navigation animated:true];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    Contato *contato = [contatos objectAtIndex:[indexPath row]];
    
    UIImage *fotoContato = [UIImage imageNamed:@"llama.jpg"];
    
    [[cell textLabel] setText:[contato nome]];
    [[cell detailTextLabel] setText:[contato telefone]];
    [[cell imageView] setImage:fotoContato];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Contato *contato = [contatos objectAtIndex:[indexPath row]];
    NSLog(@"Nome Selecionado: %@",[contato nome]);
        
    FormularioContatoController *formulario = [[FormularioContatoController alloc] initWithDelegate:self andContato:contato];
    
    // não preciso criar é só utilizar o self navigationController
    if([self navigationController]){
        [[self navigationController] pushViewController:formulario animated:TRUE];
    } else {
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:formulario];
        [self presentModalViewController:navigation animated:true];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [[self contatos] removeObjectAtIndex:[indexPath row]];
        
        // pode ser assim para remover a linha da tabela
        NSArray *indexPaths =[NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        // ou assim
        // [tableView reloadData];
    }
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    // Desafio
    
    //Contato *contato = [contatos objectAtIndex:[sourceIndexPath row]];
    //[contatos removeObjectAtIndex:[sourceIndexPath row]];
    //[contatos replaceObjectAtIndex:[destinationIndexPath row] withObject:contato];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(int) section {
    return [contatos count];
}


// chamado toda a vez que a view for ficar visível
- (void) viewWillAppear:(BOOL)animated {
    [[self tableView] reloadData];
}

- (void)viewDidLoad {
    UILongPressGestureRecognizer *gesto = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibirAcoes:)];
    [[self tableView]addGestureRecognizer:gesto];
}

- (void) exibirAcoes:(UIGestureRecognizer *) gesto{
    if ([gesto state] == UIGestureRecognizerStateBegan) {
        CGPoint ponto = [gesto locationInView:[self tableView]];
        NSIndexPath *indice = [[self tableView]indexPathForRowAtPoint:ponto];
        
        contatoPressionado = [contatos objectAtIndex:[indice row]];
        
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:[contatoPressionado nome] delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar Site", @"Abrir Mapa", @"Enviar SMS", @"Enviar Twitter", nil ];
        
        [opcoes showInView:[self view]];
    }    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;

        case 1:
            [self enviarEmail];
            break;

        case 2:
            [self abrirSite];
            break;

        case 3:
            [self mostrarMapa];
            break;

        case 4:
            [self enviarSMS];
            break;
            
        case 5:
            [self enviarTwitter];
            break;
            
        default:
            break;
    }
}

- (void) enviarSMS{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])  {
        controller.body = @"SMS message here";
        controller.recipients = [NSArray arrayWithObjects:[contatoPressionado telefone], nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}

- (void) enviarTwitter{
    TWTweetComposeViewController *controller = [[TWTweetComposeViewController alloc] init];
    [controller setInitialText:@"#ip67caelum @caelum teste de envio de msg pela app do iphone"];
    [self presentModalViewController:controller animated:YES ];
}


- (void) ligar{
    UIDevice *device =[UIDevice currentDevice];
    NSString *model = [device model];
    if([model isEqualToString:@"Iphone"]){
        NSString *numero = [NSString stringWithFormat:@"tel:%@", [contatoPressionado telefone]];
        [self abrirAplicativoComUrl:numero];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Impossível fazer a ligação" message:@"Seu dispositivo não é um iPhone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void) abrirAplicativoComUrl:(NSString *) url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


- (void) enviarEmail{
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *enviadorEmail = [[MFMailComposeViewController alloc] init];
        
        [enviadorEmail setMailComposeDelegate:self];
        [enviadorEmail setToRecipients:[NSArray arrayWithObject:[contatoPressionado email]]];
        [enviadorEmail setSubject:@"Teste"];
        [enviadorEmail setMessageBody:@"<b>teste</teste>" isHTML:TRUE];
        
        [self presentModalViewController:enviadorEmail animated:YES];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Impossível enviar o email" message:@"Seu dispositivo não permite" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) abrirSite{
    [self abrirAplicativoComUrl:[contatoPressionado site]];
}

- (void) mostrarMapa{
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", [contatoPressionado endereco]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComUrl:url];
    
}

- (void)adicionaContato:(Contato *)contato {
    [contatos addObject:contato];
}

@end
