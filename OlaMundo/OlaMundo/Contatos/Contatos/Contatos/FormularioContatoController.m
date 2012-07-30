//
//  FormularioContatoController.m
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "FormularioContatoController.h"

@implementation FormularioContatoController

@synthesize campoNome, campoEmail, campoTelefone, campoEndereco, campoSite;

- (IBAction) gravar{
    NSString *nome = [campoNome text];
    NSString *email = [campoEmail text];
    NSString *telefone = [campoTelefone text];
    NSString *endereco = [campoEndereco text];
    NSString *site = [campoSite text];
    
    NSMutableDictionary *contato = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nome,@"nome",email,@"email",telefone,@"telefone", endereco,@"endereco", site, @"site", nil];
    NSLog(@"dados: %@", contato);
    
    // ou assim:
    NSMutableDictionary *dadosDoContato = [[NSMutableDictionary alloc] init];
    [dadosDoContato setObject:nome forKey:@"nome"];
    [dadosDoContato setObject:email forKey:@"email"];
    [dadosDoContato setObject:telefone forKey:@"telefone"];
    [dadosDoContato setObject:endereco forKey:@"endereco"];
    [dadosDoContato setObject:site forKey:@"site"];
    
    NSLog(@"dados: %@", dadosDoContato);
}

@end
