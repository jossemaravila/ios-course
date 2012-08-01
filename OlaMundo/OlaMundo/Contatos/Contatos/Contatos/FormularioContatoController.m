//
//  FormularioContatoController.m
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "FormularioContatoController.h"
#import "ListaContatoViewController.h"

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@implementation FormularioContatoController

@synthesize campoNome, campoEmail, campoTelefone, campoEndereco, campoSite, campoTwitter;
@synthesize contatoSelecionado;

id<ContatoProtocol> delegate;


- (id) initWithContato:(Contato *) _contato {
    self = [self init];
    
    [self setContatoSelecionado: _contato];
    
    return self;
}

- (id) initWithDelegate:(id<ContatoProtocol>) _delegate andContato:(Contato *) _contato {
    self = [self initWithContato:_contato];
    
    delegate = _delegate;
    
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [[self navigationItem] setTitle:NSLocalizedString(@"titulo_formulario", nil)];
        
        [campoNome becomeFirstResponder];
    }
    return self;
}

- (void) viewDidLoad{
    if([self contatoSelecionado]){
        UIBarButtonItem *botaoAlterar = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"botao_alterar", nil) style:UIBarButtonItemStylePlain target:self action:@selector(alterar)];
        [[self navigationItem] setRightBarButtonItem:botaoAlterar];
        
        [self limparFormulario];
        
        [self atualizarFormularioComDadosDoContato:[self contatoSelecionado]];
    } else {
        UIBarButtonItem *botaoGravar = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"botao_gravar", nil) style:UIBarButtonItemStylePlain target:self action:@selector(gravar)];
        [[self navigationItem] setRightBarButtonItem:botaoGravar];
        
        UIBarButtonItem *botaoVoltar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar)];
        [[self navigationItem] setLeftBarButtonItem:botaoVoltar];
    }
}


- (void) limparFormulario {
    [campoNome setText:@""];
    [campoEmail setText:@""];
    [campoEndereco setText:@""];
    [campoTelefone setText:@""];
    [campoSite setText:@""];
    [campoTwitter setText:@""];
}

- (void) atualizarFormularioComDadosDoContato:(Contato *) contato {
    [campoNome setText:[contato nome]];
    [campoEndereco setText:[contato endereco]];
    [campoEmail setText:[contato email]];
    [campoTelefone setText:[contato telefone]];
    [campoSite setText:[contato site]];
    [campoTwitter setText:[contato twitter]];
}

- (Contato *) pegaDadosDoFormulario {
    Contato *novoContato = self.contatoSelecionado;
    
    if(!novoContato){
        novoContato = [[Contato alloc] init];
    }
    
    [novoContato setNome:[campoNome text]];
    [novoContato setEmail:[campoEmail text]];
    [novoContato setEndereco:[campoEndereco text]];
    [novoContato setTelefone:[campoTelefone text]];
    [novoContato setSite:[campoSite text]];
    [novoContato setTwitter:[campoTwitter text]];
    
    return novoContato;
}


- (void) validaCampo:(UITextField *) textField {
    NSString *texto = [textField text];
    if([allTrim( texto ) length] == 0){
        [textField setBackgroundColor:[UIColor colorWithRed:178/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1]];
        [textField setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];        
    } else {
        [textField setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
        [textField setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]];        
    }
}

- (Boolean) contatoEhValido:(Contato *) contato {
    Boolean resultado = true;
    
    if([allTrim( [contato nome] ) length] == 0){
        [self validaCampo:campoNome];
        resultado = false;
    }

    if([allTrim( [contato telefone] ) length] == 0){
        [self validaCampo:campoTelefone];
        resultado = false;
    }
    
    NSLog(@"Contato é válido? %s", resultado ? "true" : "false");
    
    return resultado;
}


- (void) gravar{
    NSLog(@"Gravar foi invocado");
    Contato *contato = [self pegaDadosDoFormulario];
    
    if([self contatoEhValido:contato]){
        [delegate adicionaContato:contato];
        [self cancelar];
    } else {
        [campoNome becomeFirstResponder];
    }
}

- (void) alterar{
    NSLog(@"Alterar foi invocado");
    contatoSelecionado = [self pegaDadosDoFormulario];
    
    if([self contatoEhValido:contatoSelecionado]){
        [[self navigationController ] popViewControllerAnimated:TRUE];
    } else {
        [campoNome becomeFirstResponder];
    }
}

- (void) cancelar {
    [self dismissModalViewControllerAnimated:true];
}


@end
