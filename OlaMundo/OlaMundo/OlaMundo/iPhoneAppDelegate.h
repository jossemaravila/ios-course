//
//  iPhoneAppDelegate.h
//  OlaMundo
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPhoneViewController;

@interface iPhoneAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) iPhoneViewController *viewController;

@end
