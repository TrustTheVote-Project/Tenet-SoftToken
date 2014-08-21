//
//  ConfigurationWizard.m
//  SoftPassword
//
//  Created by Aleksey Gureiev on 8/21/14.
//  Copyright (c) 2014 TrustTheVote. All rights reserved.
//

#import "ConfigurationWizard.h"

@interface ConfigurationWizard () {
    id<ConfigurationWizardCallback> callback;
}

@end

@implementation ConfigurationWizard

- (instancetype)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)onChangePrivateKey:(id)sender {
    NSOpenPanel *dlg = [NSOpenPanel openPanel];
    [dlg setCanChooseDirectories:NO];
    [dlg setCanChooseFiles:YES];
    [dlg setAllowsMultipleSelection:NO];
    
    if ([dlg runModal] == NSOKButton) {
        NSURL *url = [dlg URL];
        
        [[NSUserDefaults standardUserDefaults] setObject:[url path] forKey:@"privateKeyFile"];
    }
}

- (IBAction)onSaveAndContinue:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"configured"];
    [self close];
    
    if (callback != nil) [callback onConfigurationComplete];
}

- (void) showModal:(id<ConfigurationWizardCallback>)cb {
    callback = cb;
    [self showWindow:self];
}

@end
