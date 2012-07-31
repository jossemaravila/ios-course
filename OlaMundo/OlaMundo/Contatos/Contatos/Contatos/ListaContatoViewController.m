//
//  ListaContatoViewController.m
//  Contatos
//
//  Created by Jossemar Avila de Morais on 31/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "ListaContatoViewController.h"
#import "FormularioContatoController.h"

@implementation ListaContatoViewController

@synthesize contatos;

- (void) exibeFormulario {
    FormularioContatoController *formulario = [[FormularioContatoController alloc] initWithContatos:contatos];
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
        
        [[self navigationItem] setTitle:@"Contatos"];
        [[self navigationItem] setRightBarButtonItem:botaoNovo];        
    }
    return self;
}


@end
