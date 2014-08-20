//
//  AppDelegate.h
//  SoftPassword
//
//  Created by Aleksey Gureiev on 8/13/14.
//  Copyright (c) 2014 TrustTheVote. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <NMSSH/NMSSH.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NMSSHChannelDelegate>

@property (assign) IBOutlet NSTextField *serverField;
@property (assign) IBOutlet NSTextField *privateKeyPathField;
@property (assign) IBOutlet NSButton *requestButton;
@property (assign) IBOutlet NSSecureTextField *passphraseField;

@property (assign) IBOutlet NSTextField *passwordLabel;
@property (assign) IBOutlet NSTextField *passwordField;

@property (assign) IBOutlet NSTextField *errorLabel;
@property (assign) IBOutlet NSTextField *errorMessageLabel;

@end

