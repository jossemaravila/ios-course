//
//  EnviadorMensagens.h
//  Contatos
//
//  Created by Jossemar on 01/08/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@protocol EnviadorMensagensDelegate <NSObject, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end
