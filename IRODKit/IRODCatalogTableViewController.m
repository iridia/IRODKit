//
//  IRODCatalogTableViewController.m
//  IRODKit
//
//  Created by Evadne Wu on 10/3/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRODCatalogTableViewController.h"

@implementation IRODCatalogTableViewController

- (id) initWithInterface:(IRODInterface *)interface {

	self = [super initWithInterface:interface query:nil];
	return self;

}

- (id) initWithInterface:(IRODInterface *)interface query:(NSDictionary *)query {

	return [self initWithInterface:interface];

}

- (void) refreshData {

	[self performSelector:@selector(setLastRefreshDate:) withObject:[NSDate date]];
	
	[self.odInterface retrieveDatasetNamesOnSuccess: ^ (NSArray *names) {
	
		dispatch_async(dispatch_get_main_queue(), ^ {
		
			NSMutableDictionary *mappedNames = [NSMutableDictionary dictionaryWithCapacity:[names count]];
			
			for (NSString *aName in names) {
			
				[mappedNames setObject:@"" forKey:aName];
			
			}
			
			[self didLoadRemoteData:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:mappedNames], @"d", nil]];
		
		});
	
	} onFailure: ^ (NSError *error) {
	
		dispatch_async(dispatch_get_main_queue(), ^ {
			
			[self didFailLoadingRemoteDataWithError:error];
		
		});
		
	}];

}

@end
