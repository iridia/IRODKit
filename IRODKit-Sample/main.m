//
//  main.m
//  IRODKit-Sample
//
//  Created by Evadne Wu on 9/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IRODSAppDelegate.h"

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int returnCode = UIApplicationMain(argc, argv, nil, NSStringFromClass([IRODSAppDelegate class]));
	[pool drain];
	return returnCode;
}
