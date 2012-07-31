//
//  FormularioContatoController.m
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "FormularioContatoController.h"
#import "Contato.h"
#import "ListaContatoViewController.h"

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@implementation FormularioContatoController

@synthesize campoNome, campoEmail, campoTelefone, campoEndereco, campoSite;

@synthesize contatos;

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


- (Contato *) pegaDadosDoFormulario {
    // ou assim (a melhor forma) 
    Contato *contato = [[Contato alloc] init];
    [contato setNome:[campoNome text]];
    [contato setEmail:[campoEmail text]];
    [contato setEndereco:[campoEndereco text]];
    [contato setTelefone:[campoTelefone text]];
    [contato setSite:[campoSite text]];
    
    return contato;
}

- (Boolean) contatoEhValido:(Contato *) contato {
    Boolean resultado = true;
    
    if([allTrim( [contato nome] ) length] == 0){
        resultado = false;
    }

    if([allTrim( [contato telefone] ) length] == 0){
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

- (id) initWithContatos:(NSMutableArray *) listaContatos {
    self = [self init];
    
    [self setContatos: listaContatos];
    
    return self;
}


- (id)init {
    self = [super init];
    if (self) {
        [[self navigationItem] setTitle:@"Formulário"];
        
        UIBarButtonItem *botaoVoltar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar)];
        [[self navigationItem] setLeftBarButtonItem:botaoVoltar];

        UIBarButtonItem *botaoGravar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(gravar)];
        [[self navigationItem] setRightBarButtonItem:botaoGravar];

        [self limparFormulario];
        [campoNome becomeFirstResponder];
    }
    return self;
}

@end
