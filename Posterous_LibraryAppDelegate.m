//
//  Posterous_LibraryAppDelegate.m
//  Posterous-Library
//
//  Created by Wess Cope on 2/15/10.
//  Copyright 2010 FrenzyLabs. All rights reserved.
//

#import "Posterous_LibraryAppDelegate.h"

@implementation Posterous_LibraryAppDelegate

@synthesize window, title, body, submit;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

}


- (IBAction)submitEntry:(id)sender {
	email = @"";
	password = @"";
	
	posterous = [[Posterous alloc] initWithEmail:email andPassword:password];
	//[posterous getSites];
	
	/*
	- site_id
	- media
	- title
	- body
	- autopost
	- private
	- date
	- tags
	- source
	- sourceLink
	 */
	NSDictionary *postData = [[NSDictionary alloc] 
							  initWithObjectsAndKeys:
								@"647547", @"site_id",
								[title stringValue], @"title", 
								[body stringValue],	@"body", 
								nil];
	
	[posterous newPost:postData];
}

@end
