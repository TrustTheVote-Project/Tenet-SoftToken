//
//  AppDelegate.m
//  SoftPassword
//
//  Created by Aleksey Gureiev on 8/13/14.
//  Copyright (c) 2014 TrustTheVote. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
            
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"configured"]) {
        [self showMainWindow];
    } else {
        [self showInitialConfigurationWizard];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    if (prefsWindow != nil) [prefsWindow release];
    if (mainWindow != nil) [mainWindow release];
    if (configurationWizard != nil) [configurationWizard release];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (IBAction)onPreferences:(id)sender {
    if (prefsWindow == nil) {
        prefsWindow = [[PreferencesWindow alloc] initWithWindowNibName:@"PreferencesWindow"];
    }

    [prefsWindow showWindow:self];
}


- (void)showMainWindow {
    if (mainWindow == nil) {
        mainWindow = [[MainWindow alloc] initWithWindowNibName:@"MainWindow"];
    }
    
    [mainWindow showWindow:self];
}

- (void)showInitialConfigurationWizard {
    if (configurationWizard == nil) {
        configurationWizard = [[ConfigurationWizard alloc] initWithWindowNibName:@"ConfigurationWizard"];
    }

    [configurationWizard showModal:self];
}

- (void) onConfigurationComplete {
    [self showMainWindow];
}

@end
