//
//  iPhoneViewController.h
//  OlaMundo
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPhoneViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *campoTexto;
@property(weak, nonatomic) IBOutlet UILabel *campoLabel;

@property(weak, nonatomic) IBOutlet UITextField *campoValor1;
@property(weak, nonatomic) IBOutlet UITextField *campoValor2;
@property(weak, nonatomic) IBOutlet UILabel *campoResultado;

- (IBAction) botaoClicado;
- (IBAction) somar;
- (IBAction) atualizarValor1:(UISlider *) slider;
- (IBAction) atualizarValor2:(UISlider *) slider;

@end
