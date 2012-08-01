//
//  SSAppDelegate.m
//  Contatos
//
//  Created by Jossemar Avila de Morais on 30/07/12.
//  Copyright (c) 2012 Sirius Sofitware. All rights reserved.
//

#import "SSAppDelegate.h"
#import "FormularioContatoController.h"
#import "ListaContatoViewController.h"

@implementation SSAppDelegate

@synthesize window = _window;

@synthesize contatos;
@synthesize arquivoContatos;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    // Override point for customization after application launch.
    NSArray *userDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [userDirs objectAtIndex:0];
    [self setArquivoContatos:[NSString stringWithFormat:@"%@/ArquivoContatos", documentDir]];
    
    [self setContatos: [NSKeyedUnarchiver unarchiveObjectWithFile:[self arquivoContatos]]];
    if(![self contatos]) {
        [self setContatos:[[NSMutableArray alloc]init]];
    }
                        
    ListaContatoViewController *listagem = [[ListaContatoViewController alloc] initWithContatos:contatos];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:listagem];
    [[self window] setRootViewController:navigation];
    
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    [self callRestService];
    
    return YES;
}

- (void) callRestService {
    NSString *url = @"http://localhost:8080/spring-rest-service/contato/";
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultados = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers error:&error];
    if(!error){
        NSLog(@"Resultado: %@", [resultados description]);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [NSKeyedArchiver archiveRootObject:[self contatos] toFile:[self arquivoContatos]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [NSKeyedArchiver archiveRootObject:[self contatos] toFile:[self arquivoContatos]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
