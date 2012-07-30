//
//  FormularioContatoController.h
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormularioContatoController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *nome;
@property(weak, nonatomic) IBOutlet UITextField *email;
@property(weak, nonatomic) IBOutlet UITextField *telefone;
@property(weak, nonatomic) IBOutlet UITextField *endereco;
@property(weak, nonatomic) IBOutlet UITextField *site;


@end
