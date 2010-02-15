//
//  Posterous_LibraryAppDelegate.h
//  Posterous-Library
//
//  Created by Wess Cope on 2/15/10.
//  Copyright 2010 FrenzyLabs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "posterous.h"

@interface Posterous_LibraryAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;

	NSTextField *title;
	NSTextField *body;
	NSButton *submit;
	
	Posterous *posterous;
	NSString *email;
	NSString *password;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *title;
@property (assign) IBOutlet NSTextField *body;
@property (assign) IBOutlet NSButton *submit;

-(IBAction)submitEntry:(id)sender;

@end
