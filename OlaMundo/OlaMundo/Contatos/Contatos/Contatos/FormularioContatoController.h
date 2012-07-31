//
//  FormularioContatoController.h
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface FormularioContatoController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *campoNome;
@property(weak, nonatomic) IBOutlet UITextField *campoEmail;
@property(weak, nonatomic) IBOutlet UITextField *campoTelefone;
@property(weak, nonatomic) IBOutlet UITextField *campoEndereco;
@property(weak, nonatomic) IBOutlet UITextField *campoSite;

@property(weak) NSMutableArray *contatos;
- (IBAction)validaCampo:(id)sender;

- (id) initWithListaDeContatos:(NSMutableArray *) listaContatos eContato:(Contato *) contatoSelecionado;

@end
