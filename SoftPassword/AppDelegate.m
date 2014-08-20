//
//  AppDelegate.m
//  SoftPassword
//
//  Created by Aleksey Gureiev on 8/13/14.
//  Copyright (c) 2014 TrustTheVote. All rights reserved.
//

#import "AppDelegate.h"
#import <NMSSH/NMSSH.h>
#import <NMSSH/NMSSHChannel.h>

@interface AppDelegate ()
@property (nonatomic, retain) IBOutlet NSWindow *window;
@end



@implementation AppDelegate
            
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [prefsWindow release];
    prefsWindow = nil;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (IBAction)onPreferences:(id)sender {
    NSLog(@"Calling preferences");
    
    if (prefsWindow == nil) {
        prefsWindow = [[PreferencesWindow alloc] initWithWindowNibName:@"PreferencesWindow"];
    }

    [prefsWindow showWindow:self];
}

- (IBAction)onRequestPassword:(id)sender {
    [self.requestButton setHidden:YES];
    [self.passwordField setStringValue:@""];

    [self performSelectorInBackground:@selector(requestPassword) withObject:nil];
}

- (void)requestPassword {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    
    NSUserDefaults *ud   = [NSUserDefaults standardUserDefaults];
    NSString *server     = [ud objectForKey:@"serverAddress"];
    NSString *user       = @"otp";
    NSString *privateKey = [ud objectForKey:@"privateKeyFile"];
    NSString *passphrase = [self.passphraseField stringValue];
    
    NMSSHSession *session = [NMSSHSession connectToHost:server withUsername:user];
    [session.channel setPtyTerminalType:NMSSHChannelPtyTerminalAnsi];
    
    
    if (session.isConnected) {
        NSLog(@"Connected");
        
        [session authenticateByPublicKey:nil privateKey:privateKey andPassword:passphrase];
         
        if (session.isAuthorized) {
            NSLog(@"Authorized");
            
            session.channel.delegate = self;

            NSError *err = nil;
            [session.channel startShell:&err];
        } else {
            [self performSelectorOnMainThread:@selector(showError:) withObject:@"Check your key or passphrase." waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector(onRequestComplete) withObject:nil waitUntilDone:NO];
        }
    } else {
        [self performSelectorOnMainThread:@selector(showError:) withObject:@"Couldn't connect to server" waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(onRequestComplete) withObject:nil waitUntilDone:NO];
    }
    
    [pool release];
}

- (void)onRequestSuccess:(NSString *)password {
    [self showPassword:password];
}

- (void)onRequestError:(NSString *)error {
    [self showError:error];
}

- (void)onRequestComplete {
    [self.requestButton setHidden:NO];
}

- (void)channel:(NMSSHChannel *)channel didReadData:(NSString *)message {
    NSLog(@"Read data: %@", message);

    if ([message hasPrefix:@"SUCCESS"]) {
        NSArray *components = [message componentsSeparatedByString:@" "];
        NSString *password  = [components objectAtIndex:1];
        [self performSelectorOnMainThread:@selector(onRequestSuccess:) withObject:password waitUntilDone:YES];
    } else {
        NSLog(@"Error response: %@", message);
    }

    [self performSelectorOnMainThread:@selector(onRequestComplete) withObject:nil waitUntilDone:NO];
}

- (void)channel:(NMSSHChannel *)channel didReadError:(NSString *)error{
    [self performSelectorOnMainThread:@selector(onRequestError:) withObject:error waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(onRequestComplete) withObject:nil waitUntilDone:NO];
}

- (void)showPassword:(NSString *)password {
    [self.passwordLabel setHidden:NO];
    [self.passwordField setHidden:NO];
    [self.passwordField setStringValue:password];
    
    [self.errorLabel setHidden:YES];
    [self.errorMessageLabel setHidden:YES];
    [self.errorMessageLabel setStringValue:@""];
}

- (void)showError:(NSString *)error {
    [self.passwordLabel setHidden:YES];
    [self.passwordField setHidden:YES];
    [self.passwordField setStringValue:@""];
    
    [self.errorLabel setHidden:NO];
    [self.errorMessageLabel setHidden:NO];
    [self.errorMessageLabel setStringValue:error];
}

@end
