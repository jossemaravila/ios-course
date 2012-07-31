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

- (void) exibeFormulario {
    FormularioContatoController *formulario = [[FormularioContatoController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:formulario];
    
    [self presentModalViewController:navigation animated:true];
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
