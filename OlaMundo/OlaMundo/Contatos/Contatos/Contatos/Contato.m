//
//  Contato.m
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@synthesize nome;
@synthesize email;
@synthesize endereco; 
@synthesize telefone;
@synthesize site;
@synthesize twitter;

- (void) encodeWithCoder:(NSCoder *) coder{
    [coder encodeObject:[self nome] forKey:@"nome"];
    [coder encodeObject:[self email] forKey:@"email"];
    [coder encodeObject:[self telefone] forKey:@"telefone"];
    [coder encodeObject:[self endereco] forKey:@"endereco"];
    [coder encodeObject:[self site] forKey:@"site"];
    [coder encodeObject:[self twitter] forKey:@"twitter"];
}

- (id) initWithCoder:(NSCoder *) decoder{
    self = [super init];
    if(self){
        [self setNome:[decoder decodeObjectForKey:@"nome"]];
        [self setEmail:[decoder decodeObjectForKey:@"email"]];
        [self setTelefone:[decoder decodeObjectForKey:@"telefone"]];
        [self setEndereco:[decoder decodeObjectForKey:@"endereco"]];
        [self setSite:[decoder decodeObjectForKey:@"site"]];
        [self setTwitter:[decoder decodeObjectForKey:@"twitter"]];
    }
    return self;
}


+ (Contato*) comDicionario: (NSDictionary *) dicionario {
    Contato *contato = [[Contato alloc] init];
    [contato setNome: [dicionario objectForKey:@"nome"]];
    [contato setEmail: [dicionario objectForKey:@"email"]];
    [contato setTelefone: [dicionario objectForKey:@"telefone"]];
    [contato setEndereco: [dicionario objectForKey:@"endereco"]];
    [contato setSite: [dicionario objectForKey:@"site"]];
    [contato setTwitter: [dicionario objectForKey:@"twitter"]];
    
    return contato;
}

@end
