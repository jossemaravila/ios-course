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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Contato *contato = [contatos objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[contato nome]];
    
    return cell;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {    
    return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(int) section {
    return [contatos count];
}


- (void) viewWillAppear:(BOOL)animated {
    [[self tableView] reloadData];
}

@end
