//
//  IRODInterface.m
//  IRODKit
//
//  Created by Evadne Wu on 9/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRODInterface.h"

@interface IRODInterface ()
@property (nonatomic, readwrite, retain) NSString *containerName;
@property (nonatomic, readwrite, retain) NSString *datasetName;
@end

@implementation IRODInterface
@synthesize containerName, datasetName;

+ (id) interfaceForBaseURL:(NSURL *)anURL container:(NSString *)inContainerName dataset:(NSString *)inDatasetName {

	IRWebAPIContext *context = [[[IRWebAPIContext alloc] initWithBaseURL:anURL] autorelease];
	
	IRWebAPIEngine *engine = [[[IRWebAPIEngine alloc] initWithContext:context] autorelease];
	engine.parser = IRWebAPIResponseDefaultJSONParserMake();
	
	IRODInterface *returnedInstance = [[[self alloc] initWithEngine:engine authenticator:nil] autorelease];
	returnedInstance.containerName = inContainerName;
	returnedInstance.datasetName = inDatasetName;
	
	return returnedInstance;

}

- (void) performQuery:(id)aQuery onSuccess:(void(^)(NSDictionary *results))successBlock onFailure:(void(^)(NSError *error))failureBlock {
	
	NSParameterAssert(self.containerName);
	NSParameterAssert(self.datasetName);
	
	NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
		@"json", @"format",
	nil];
	
	if (aQuery) {
		NSParameterAssert([(id<NSObject>)aQuery isKindOfClass:[NSDictionary class]]);
		[queryParams addEntriesFromDictionary:(NSDictionary *)aQuery];
	}
	
	[self.engine fireAPIRequestNamed:[NSString stringWithFormat:@"%@/%@", self.containerName, self.datasetName] withArguments:queryParams successHandler:^(NSDictionary *inResponseOrNil, NSDictionary *inResponseContext, BOOL *outNotifyDelegate, BOOL *outShouldRetry) {
	
		if (successBlock)
			successBlock(inResponseOrNil);
		
	} failureHandler: ^ (NSDictionary *inResponseOrNil, NSDictionary *inResponseContext, BOOL *outNotifyDelegate, BOOL *outShouldRetry) {
	
		if (failureBlock)
			failureBlock([NSError errorWithDomain:@"com.iridia.IRODKit" code:0 userInfo:inResponseContext]);
		
	}];

}

@end
