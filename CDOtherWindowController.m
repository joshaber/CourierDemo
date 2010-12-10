//
//  CDOtherWindowController.m
//  CourierDemo
//
//  Created by Josh Abernathy on 12/7/10.
//  Copyright 2010 Maybe Apps, LLC. All rights reserved.
//

#import "CDOtherWindowController.h"


@implementation CDOtherWindowController


#pragma mark API

+ (CDOtherWindowController *)defaultWindowController {
    return [[[self alloc] initWithWindowNibName:NSStringFromClass(self)] autorelease];
}

@end
