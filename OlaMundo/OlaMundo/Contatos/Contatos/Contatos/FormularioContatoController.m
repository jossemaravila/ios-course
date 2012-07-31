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

@synthesize campoNome, campoEmail, campoTelefone, campoEndereco, campoSite;
@synthesize contatos;
@synthesize contatoSelecionado;

- (void) limparFormulario {
    [campoNome setText:@""];
    [campoEmail setText:@""];
    [campoEndereco setText:@""];
    [campoTelefone setText:@""];
    [campoSite setText:@""];
}

- (void) cancelar {
    NSLog(@"Contatos = %i", [contatos count]);
    [self dismissModalViewControllerAnimated:true];
}

- (void) atualizarFormularioComDadosDoContato:(Contato *) contato {
    [campoNome setText:[contato nome]];
    [campoEndereco setText:[contato endereco]];
    [campoEmail setText:[contato email]];
    [campoTelefone setText:[contato telefone]];
    [campoSite setText:[contato site]];
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
    Contato *contato = [self pegaDadosDoFormulario];
    if([self contatoEhValido:contato]){
        [contatos addObject:contato];
        [self cancelar];
    } else {
        [campoNome becomeFirstResponder];
    }
}

- (void) alterar{
    contatoSelecionado = [self pegaDadosDoFormulario];
    if([self contatoEhValido:contatoSelecionado]){
        [self cancelar];
    } else {
        [campoNome becomeFirstResponder];
    }
}

- (id) initWithContato:(Contato *) contato {
    self = [self init];
    
    [self setContatoSelecionado: contato];
    if(contato){
        UIBarButtonItem *botaoAlterar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(alterar)];
        [[self navigationItem] setRightBarButtonItem:botaoAlterar];            
    } else {
        UIBarButtonItem *botaoGravar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(gravar)];
        [[self navigationItem] setRightBarButtonItem:botaoGravar];
    }
    
    return self;
}


- (id) initWithListaDeContatos:(NSMutableArray *) listaContatos {
    self = [self init];
    
    UIBarButtonItem *botaoGravar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(gravar)];
    [[self navigationItem] setRightBarButtonItem:botaoGravar];

    [self setContatos: listaContatos];    
    
    return self;
}


- (id)init {
    self = [super init];
    if (self) {
        [[self navigationItem] setTitle:@"Formulário"];
        
        UIBarButtonItem *botaoVoltar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar)];
        [[self navigationItem] setLeftBarButtonItem:botaoVoltar];

        [campoNome becomeFirstResponder];
    }
    return self;
}

- (void) viewDidLoad{
    if([self contatoSelecionado]){
        [self limparFormulario];
        
        [self atualizarFormularioComDadosDoContato:[self contatoSelecionado]];    
    }
}

@end
