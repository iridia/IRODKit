//
//  IRODFeedTableViewController.m
//  IRODKit
//
//  Created by Evadne Wu on 9/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRODFeedTableViewController.h"


@interface IRODFeedTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readwrite, retain) NSArray *storedRemoteResponse;

@end


@implementation IRODFeedTableViewController
@synthesize storedRemoteResponse;
@synthesize onSelection;

- (void) dealloc {

	[storedRemoteResponse release];
	[onSelection release];
	[super dealloc];

}

- (void) loadView {

	self.view = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;

}

- (void) didLoadRemoteData:(NSDictionary *)incomingData {

	NSParameterAssert([NSThread isMainThread]);

	self.storedRemoteResponse = [incomingData objectForKey:@"d"];
	[self.tableView reloadData];

}

- (UITableView *) tableView {

	return (UITableView *)(self.view);

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

	return [self.storedRemoteResponse count];
	
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	if (!self.storedRemoteResponse)
		return 0;
		
	NSDictionary *itemDictionary = [self.storedRemoteResponse objectAtIndex:section];
	return [itemDictionary count];

}

- (UITableViewCell *) tableView:(UITableView *)aTV cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString * const identifier = @"Cell";
	UITableViewCell *cell = [aTV dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
	};
	
	NSDictionary *itemDictionary = [self.storedRemoteResponse objectAtIndex:indexPath.section];
	NSString *itemElementKey = [[itemDictionary allKeys] objectAtIndex:indexPath.row];
	NSString *itemElementValue = [itemDictionary objectForKey:itemElementKey];
	
	cell.textLabel.text = itemElementKey;
	cell.detailTextLabel.text = itemElementValue;
		
	return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	NSDictionary *itemDictionary = [self.storedRemoteResponse objectAtIndex:indexPath.section];
	NSString *itemElementKey = [[itemDictionary allKeys] objectAtIndex:indexPath.row];
	NSString *itemElementValue = [itemDictionary objectForKey:itemElementKey];

	if (self.onSelection)
		self.onSelection(indexPath, itemElementKey, itemElementValue);

}

@end
