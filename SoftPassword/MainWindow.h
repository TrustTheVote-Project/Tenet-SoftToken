//
//  MainWindow.h
//  SoftPassword
//
//  Created by Aleksey Gureiev on 8/21/14.
//  Copyright (c) 2014 TrustTheVote. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <NMSSH/NMSSH.h>
//#import <NMSSH/NMSSHChannel.h>

@interface MainWindow : NSWindowController <NMSSHChannelDelegate>

@property (assign) IBOutlet NSButton *requestButton;
@property (assign) IBOutlet NSSecureTextField *passphraseField;

@property (assign) IBOutlet NSTextField *passwordLabel;
@property (assign) IBOutlet NSTextField *passwordField;

@property (assign) IBOutlet NSTextField *errorLabel;
@property (assign) IBOutlet NSTextField *errorMessageLabel;

@end
