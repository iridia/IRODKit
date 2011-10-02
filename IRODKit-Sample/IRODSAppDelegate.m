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
#import "IRODCatalogTableViewController.h"

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
	
	IRODInterface *listingInterface = [IRODInterface interfaceForBaseURL:odBaseURL container:odContainer dataset:nil];
	__block IRODCatalogTableViewController *listingVC = [[[IRODCatalogTableViewController alloc] initWithInterface:listingInterface] autorelease];
	listingVC.title = @"Everything";
	listingVC.onSelection = ^ (NSIndexPath *indexPath, NSString *key, NSString *value) {
	
		IRODInterface *feedInterface = [IRODInterface interfaceForBaseURL:odBaseURL container:odContainer dataset:key];
		IRODFeedTableViewController *feedVC = [[[IRODFeedTableViewController alloc] initWithInterface:feedInterface query:nil] autorelease];
		feedVC.title = key;
		[listingVC.navigationController pushViewController:feedVC animated:YES];
	
	};
	
	self.window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:listingVC] autorelease];
	
	return YES;
}

@end