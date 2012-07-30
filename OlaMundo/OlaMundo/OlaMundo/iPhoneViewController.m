//
//  iPhoneViewController.m
//  OlaMundo
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "iPhoneViewController.h"

@implementation iPhoneViewController

@synthesize campoLabel, campoTexto, campoValor1, campoValor2, campoResultado;


-(IBAction)somar{
    int valor1 = [[campoValor1 text] intValue];
    int valor2 = [[campoValor2 text] intValue];
    
    int soma = valor1 + valor2;
    
    [campoResultado setText:[NSString stringWithFormat:@"%i",soma]];
}

-(IBAction)botaoClicado{
    [campoLabel setText:[campoTexto text]];
    NSLog(@"O texto digitado foi : %@", [campoTexto text]);
}


-(IBAction)atualizarValor1:(UISlider *)slider{
    float valorSlider = [slider value];
    [campoValor1 setText:[NSString stringWithFormat:@"%.0f", valorSlider]];
}

-(IBAction)atualizarValor2:(UISlider *)slider{
    float valorSlider = [slider value];
    [campoValor2 setText:[NSString stringWithFormat:@"%.0f", valorSlider]];
}

@end
