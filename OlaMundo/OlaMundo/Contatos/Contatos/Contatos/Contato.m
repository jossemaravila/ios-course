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

- (void) encodeWithCoder:(NSCoder *) coder{
    [coder encodeObject:[self nome] forKey:@"nome"];
    [coder encodeObject:[self email] forKey:@"email"];
    [coder encodeObject:[self telefone] forKey:@"telefone"];
    [coder encodeObject:[self endereco] forKey:@"endereco"];
    [coder encodeObject:[self site] forKey:@"site"];
}

- (id) initWithCoder:(NSCoder *) decoder{
    self = [super init];
    if(self){
        [self setNome:[decoder decodeObjectForKey:@"nome"]];
        [self setEmail:[decoder decodeObjectForKey:@"email"]];
        [self setTelefone:[decoder decodeObjectForKey:@"telefone"]];
        [self setEndereco:[decoder decodeObjectForKey:@"endereco"]];
        [self setSite:[decoder decodeObjectForKey:@"site"]];
    }
    return self;
}

@end
