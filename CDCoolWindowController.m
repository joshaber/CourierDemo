//
//  CDCoolWindowController.m
//  CourierDemo
//
//  Created by Josh Abernathy on 12/6/10.
//  Copyright 2010 Maybe Apps, LLC. All rights reserved.
//

#import "CDCoolWindowController.h"


@implementation CDCoolWindowController


#pragma mark API

+ (CDCoolWindowController *)defaultWindowController {
    return [[[self alloc] initWithWindowNibName:NSStringFromClass(self)] autorelease];
}

@end
