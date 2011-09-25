//
//  IRODFeedViewController.m
//  IRODKit
//
//  Created by Evadne Wu on 9/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRODFeedViewController.h"

@interface IRODFeedViewController ()

- (void) configureWithInterface:(IRODInterface *)interface query:(NSDictionary *)query;
@property (nonatomic, readwrite, retain) IRODInterface *odInterface;
@property (nonatomic, readwrite, retain) NSDictionary *odQuery;

@property (nonatomic, readwrite, retain) NSDate *lastRefreshDate;
@property (nonatomic, readwrite, assign) NSTimeInterval refreshInterval;

@end


@implementation IRODFeedViewController
@synthesize odInterface, odQuery;
@synthesize lastRefreshDate, refreshInterval;

- (id) initWithInterface:(IRODInterface *)interface query:(NSDictionary *)query {

	self = [self initWithNibName:nil bundle:nil];
	[self configureWithInterface:interface query:query];
	
	return self;

}

- (void) configureWithInterface:(IRODInterface *)interface query:(NSDictionary *)query {

	self.lastRefreshDate = nil;
	self.refreshInterval = 30;
	self.odInterface = interface;
	self.odQuery = query;

}

- (void) refreshDataIfNecessary {

	if (self.lastRefreshDate)
		if ([[NSDate date] timeIntervalSinceDate:self.lastRefreshDate] < self.refreshInterval)
			return;
			
	[self refreshData];
	
}

- (void) refreshData {

	NSParameterAssert(self.odInterface);

	self.lastRefreshDate = [NSDate date];
	[self.odInterface performQuery:self.odQuery onSuccess: ^ (NSDictionary *results) {
	
		dispatch_async(dispatch_get_main_queue(), ^ {
			
			[self didLoadRemoteData:results];
			
		});
		
	} onFailure: ^ (NSError *error) {
	
		dispatch_async(dispatch_get_main_queue(), ^ {

			[[[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
		
		});
		
	}];

}

- (void) didLoadRemoteData:(NSDictionary *)incomingData {

	NSLog(@"%s Requires Concrete Implementation.", __PRETTY_FUNCTION__);

}

- (void) viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];
	[self refreshDataIfNecessary];

}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
