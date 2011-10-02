//
//  IRODFeedViewController.h
//  IRODKit
//
//  Created by Evadne Wu on 9/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRODInterface.h"

@interface IRODFeedViewController : UIViewController

//	The feed view controller is a generic and overridable view controller subclass integrating IRODInterface and friends
//	It provides contrsucts showing contents from a generic OData Protocol feed in the view

- (id) initWithInterface:(IRODInterface *)inteface query:(NSDictionary *)query;

@property (nonatomic, readonly, retain) IRODInterface *odInterface;
@property (nonatomic, readonly, retain) NSDictionary *odQuery;

- (void) refreshDataIfNecessary;
- (void) refreshData;
- (void) didLoadRemoteData:(NSDictionary *)incomingData;
- (void) didFailLoadingRemoteDataWithError:(NSError *)error;

@end
