//
//  SSAppDelegate.h
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong) NSMutableArray *contatos;

@property(strong) NSString *arquivoContatos;

@end
