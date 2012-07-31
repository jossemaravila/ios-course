//
//  FormularioContatoController.m
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "FormularioContatoController.h"
#import "Contato.h"

@implementation FormularioContatoController

@synthesize campoNome, campoEmail, campoTelefone, campoEndereco, campoSite;

@synthesize contatos;

- (id)init {
    self = [super init];
    if (self) {
        [self setContatos: [[NSMutableArray alloc] init]];
    }
    return self;
}

- (void) limparFormulario {
    [campoNome setText:@""];
    [campoEmail setText:@""];
    [campoEndereco setText:@""];
    [campoTelefone setText:@""];
    [campoSite setText:@""];
}

- (IBAction) gravar{
    NSString *nome = [campoNome text];
    NSString *email = [campoEmail text];
    NSString *telefone = [campoTelefone text];
    NSString *endereco = [campoEndereco text];
    NSString *site = [campoSite text];
    
    // podemos guardar informações em memória assim 
    NSMutableDictionary *contatoDicionario = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nome,@"nome",email,@"email",telefone,@"telefone", endereco,@"endereco", site, @"site", nil];
    NSLog(@"dados: %@", contatoDicionario);
    
    // ou assim:
    NSMutableDictionary *dadosDoContato = [[NSMutableDictionary alloc] init];
    [dadosDoContato setObject:nome forKey:@"nome"];
    [dadosDoContato setObject:email forKey:@"email"];
    [dadosDoContato setObject:telefone forKey:@"telefone"];
    [dadosDoContato setObject:endereco forKey:@"endereco"];
    [dadosDoContato setObject:site forKey:@"site"];
    
    NSLog(@"dados: %@", dadosDoContato);
    
    // ou assim (a melhor forma)
    Contato *contato = [[Contato alloc] init];
    [contato setNome:[campoNome text]];
    [contato setEmail:[campoEmail text]];
    [contato setEndereco:[campoEndereco text]];
    [contato setTelefone:[campoTelefone text]];
    [contato setSite:[campoSite text]];
    
    NSLog(@"contato nome: %@", [contato nome]);

    // agora adicionando o elemento ao array
    [contatos addObject:contato];
    
    [self limparFormulario];
}



- (IBAction) visualizarContatos {
    for (Contato *contato in contatos) {
        NSLog(@"Nome: %@", [contato nome]);
    }
}

@end
