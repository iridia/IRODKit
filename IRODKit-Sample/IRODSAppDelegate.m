//
//  IRODSAppDelegate.m
//  IRODKit-Sample
//
//  Created by Evadne Wu on 9/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRODSAppDelegate.h"
#import "IRODInterface.h"
#import "IRODFeedTableViewController.h"

@implementation IRODSAppDelegate

@synthesize window = _window;

- (void) dealloc {
	[_window release];
	[super dealloc];
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	
	NSURL *odBaseURL = [NSURL URLWithString:@"http://taipeicityopendata.cloudapp.net/v1/"];
	NSString *odContainer = @"TaipeiOGDI";
	NSString *odDataset = @"G67ACUOLDTREE0501";
	//	NSDictionary *odQuery = nil;
	
	IRODInterface *feedInterface = [IRODInterface interfaceForBaseURL:odBaseURL container:odContainer dataset:odDataset];
	
	[feedInterface retrieveDatasetNamesOnSuccess:^(NSArray *names) {
		
		NSLog(@"nam %@", names);
		
	} onFailure:^(NSError *error) {
		
	}];
	
	//	IRODFeedViewController *feedVC = [[[IRODFeedTableViewController alloc] initWithInterface:feedInterface query:odQuery] autorelease];
	//	self.window.rootViewController = feedVC;
	
	return YES;
}

@end