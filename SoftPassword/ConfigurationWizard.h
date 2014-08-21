//
//  ConfigurationWizard.h
//  SoftPassword
//
//  Created by Aleksey Gureiev on 8/21/14.
//  Copyright (c) 2014 TrustTheVote. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ConfigurationWizardCallback <NSObject>

- (void) onConfigurationComplete;

@end



@interface ConfigurationWizard : NSWindowController

- (void) showModal:(id<ConfigurationWizardCallback>)callback;

@end
