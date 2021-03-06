//
//  ListaContatoViewController.h
//  Contatos
//
//  Created by Jossemar Avila de Morais on 31/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContatoProtocol.h"
#import "EnviadorMensagensDelegate.h"

@interface ListaContatoViewController : UITableViewController<ContatoProtocol, UIActionSheetDelegate, EnviadorMensagensDelegate>

@property(weak) NSMutableArray *contatos;

- (id) initWithContatos:(NSMutableArray *) listaContatos;

@end
