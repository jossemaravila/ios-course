//
//  FormularioContatoController.h
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ContatoProtocol.h"

@interface FormularioContatoController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *campoNome;
@property(weak, nonatomic) IBOutlet UITextField *campoEmail;
@property(weak, nonatomic) IBOutlet UITextField *campoTelefone;
@property(weak, nonatomic) IBOutlet UITextField *campoEndereco;
@property(weak, nonatomic) IBOutlet UITextField *campoSite;

@property(weak) Contato *contatoSelecionado;

- (IBAction)validaCampo:(id)sender;

- (id) initWithContato:(Contato *) _contatoSelecionado;

- (id) initWithDelegate:(id<ContatoProtocol>) _delegate andContato:(Contato *) _contatoSelecionado;

@end
