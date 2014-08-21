//
//  AppDelegate.h
//  SoftPassword
//
//  Created by Aleksey Gureiev on 8/13/14.
//  Copyright (c) 2014 TrustTheVote. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferencesWindow.h"
#import "MainWindow.h"
#import "ConfigurationWizard.h"


@interface AppDelegate : NSObject <NSApplicationDelegate, ConfigurationWizardCallback> {
    PreferencesWindow   *prefsWindow;
    MainWindow          *mainWindow;
    ConfigurationWizard *configurationWizard;
}

@end

