//
//  ContatoProtocol.h
//  Contatos
//
//  Created by Jossemar on 01/08/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol ContatoProtocol <NSObject>

- (void) adicionaContato:(Contato *) contato;

@end
