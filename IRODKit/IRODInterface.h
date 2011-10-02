//
//  IRODInterface.h
//  IRODKit
//
//  Created by Evadne Wu on 9/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWebAPIKit.h"

@interface IRODInterface : IRWebAPIInterface

+ (id) interfaceForBaseURL:(NSURL *)anURL container:(NSString *)containerName dataset:(NSString *)datasetName;

- (void) retrieveDatasetNamesOnSuccess:(void(^)(NSArray *names))successBlock onFailure:(void(^)(NSError *error))failureBlock;
- (void) performQuery:(id)aQuery onSuccess:(void(^)(NSDictionary *results))successBlock onFailure:(void(^)(NSError *error))failureBlock;

@property (nonatomic, readonly, retain) NSString *containerName;
@property (nonatomic, readonly, retain) NSString *datasetName;

@end
