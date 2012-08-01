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

@implementation ListaContatoViewController

@synthesize contatos;

- (void) exibeFormulario {
    FormularioContatoController *formulario = [[FormularioContatoController alloc] initWithDelegate:self andContato:nil];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:formulario];
    
    [self presentModalViewController:navigation animated:true];
}


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


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(int) section {
    return [contatos count];
}


// chamado toda a vez que a view for ficar visível
- (void) viewWillAppear:(BOOL)animated {
    [[self tableView] reloadData];
}

- (void)adicionaContato:(Contato *)contato {
    [contatos addObject:contato];
}

@end
