//
//  CDAppDelegate.m
//  CourierDemo
//
//  Created by Josh Abernathy on 12/6/10.
//  Copyright 2010 Maybe Apps, LLC. All rights reserved.
//

#import "CDAppDelegate.h"
#import "CDCoolWindowController.h"
#import "CDOtherWindowController.h"
#import "JAAnimatingContainer.h"

@interface CDAppDelegate ()
- (void)animateCoolWindowIn;
- (void)animateOtherWindowIn;
@end


@implementation CDAppDelegate


#pragma mark NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [self.window makeKeyAndOrderFront:nil];
    
    CDCoolWindowController *windowController = [CDCoolWindowController defaultWindowController];
    NSView *view = [[windowController window] contentView];
    NSImage *image = [[NSImage alloc] initWithData:[view dataWithPDFInsideRect:[view bounds]]];
    self.imageView.image = image;
}


#pragma mark API

@synthesize window;
@synthesize imageView;

- (IBAction)createNewDocument:(id)sender {
    [self animateCoolWindowIn];
    [self animateOtherWindowIn];
}

- (void)animateCoolWindowIn {
    CDCoolWindowController *windowController = [CDCoolWindowController defaultWindowController];
    
    NSDisableScreenUpdates();
    [windowController.window makeKeyAndOrderFront:nil];
    JAAnimatingContainer *container = [JAAnimatingContainer containerFromWindow:windowController.window];
    [windowController.window orderOut:nil];
    NSEnableScreenUpdates();
    
    container.animationLayer.zPosition = 99;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    container.animationLayer.contentsGravity = kCAGravityResizeAspect;
    container.animationLayer.bounds = CGRectMake(0.0f, 0.0f, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
    NSPoint originalOrigin = [self.imageView.window convertBaseToScreen:[self.imageView convertPoint:self.imageView.bounds.origin toView:nil]];
    container.animationLayer.position = CGPointMake(originalOrigin.x + self.imageView.bounds.size.width/2, originalOrigin.y + self.imageView.bounds.size.height/2);
    [CATransaction commit];
    
    [container swapViewWithContainer];
    
    static const CGFloat xOffset = 250.0f;
    
    container.didFinishBlock = ^(JAAnimatingContainer *currentContainer, CAAnimation *animation) {
        CDCoolWindowController *windowController = [CDCoolWindowController defaultWindowController];
        
        [windowController.window setFrameOrigin:NSMakePoint(currentContainer.animationLayer.position.x - windowController.window.frame.size.width/2 + xOffset, currentContainer.animationLayer.position.y - windowController.window.frame.size.height/2)];
        
        NSDisableScreenUpdates();
        [currentContainer swapContainerWithView];
        [self.window addChildWindow:windowController.window ordered:NSWindowAbove];
        [windowController.window makeKeyAndOrderFront:nil];
        [windowController.window display];
        NSEnableScreenUpdates();
    };
    
    const CFTimeInterval duration = ([self.window currentEvent].modifierFlags & NSShiftKeyMask) ? 10.0f : 0.5f;
    
    CABasicAnimation *zoomAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    zoomAnimation.toValue = [NSValue valueWithPoint:NSMakePoint(windowController.window.frame.size.width / self.imageView.bounds.size.width, windowController.window.frame.size.height / self.imageView.bounds.size.height)];
    zoomAnimation.fillMode = kCAFillModeForwards;
    zoomAnimation.removedOnCompletion = NO;
    zoomAnimation.duration = duration;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveAnimation.toValue = [NSValue valueWithPoint:NSMakePoint(container.animationLayer.position.x + xOffset, container.animationLayer.position.y)];
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.duration = duration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:zoomAnimation, moveAnimation, nil];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [container startAnimation:group];
}

- (void)animateOtherWindowIn {
    CDOtherWindowController *windowController = [CDOtherWindowController defaultWindowController];
    
    NSDisableScreenUpdates();
    [windowController.window makeKeyAndOrderFront:nil];
    JAAnimatingContainer *container = [JAAnimatingContainer containerFromWindow:windowController.window];
    [windowController.window orderOut:nil];
    NSEnableScreenUpdates();
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    container.animationLayer.contentsGravity = kCAGravityResizeAspect;
    container.animationLayer.bounds = CGRectMake(0.0f, 0.0f, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
    NSPoint originalOrigin = [self.imageView.window convertBaseToScreen:[self.imageView convertPoint:self.imageView.bounds.origin toView:nil]];
    container.animationLayer.position = CGPointMake(originalOrigin.x + self.imageView.bounds.size.width/2, originalOrigin.y + self.imageView.bounds.size.height/2);
    [CATransaction commit];
    
    [container swapViewWithContainer];
    
    static const CGFloat xOffset = -250.0f;
    
    container.didFinishBlock = ^(JAAnimatingContainer *currentContainer, CAAnimation *animation) {
        CDOtherWindowController *windowController = [CDOtherWindowController defaultWindowController];
        
        [windowController.window setFrameOrigin:NSMakePoint(currentContainer.animationLayer.position.x - windowController.window.frame.size.width/2 + xOffset, currentContainer.animationLayer.position.y - windowController.window.frame.size.height/2)];
        
        NSDisableScreenUpdates();
        [currentContainer swapContainerWithView];
        [self.window addChildWindow:windowController.window ordered:NSWindowAbove];
        [windowController.window makeKeyAndOrderFront:nil];
        [windowController.window display];
        NSEnableScreenUpdates();
    };
    
    const CFTimeInterval duration = ([self.window currentEvent].modifierFlags & NSShiftKeyMask) ? 10.0f : 0.5f;
    
    CABasicAnimation *zoomAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    zoomAnimation.toValue = [NSValue valueWithPoint:NSMakePoint(windowController.window.frame.size.width / self.imageView.bounds.size.width, windowController.window.frame.size.height / self.imageView.bounds.size.height)];
    zoomAnimation.fillMode = kCAFillModeForwards;
    zoomAnimation.removedOnCompletion = NO;
    zoomAnimation.duration = duration;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveAnimation.toValue = [NSValue valueWithPoint:NSMakePoint(container.animationLayer.position.x + xOffset, container.animationLayer.position.y)];
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.duration = duration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:zoomAnimation, moveAnimation, nil];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [container startAnimation:group];
}

@end
