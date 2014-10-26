//
//  BUNAppDelegate.m
//  qcViewSample
//
//  Created by JFR on 13/12/2013.
//  Copyright (c) 2013 JFR. All rights reserved.
//

#import "BUNAppDelegate.h"

@implementation BUNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    qcView = [[QCView alloc] initWithFrame:[self.window.contentView frame]];
    [self.window.contentView addSubview:qcView];
    
    
    //THIS IS FOR PROGRAMMATIC AUTO-LAYOUT...
    [qcView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = NSDictionaryOfVariableBindings(qcView);
    [self.window.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[qcView]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    [self.window.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[qcView]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    
    
    if(![qcView loadCompositionFromFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"qtz"]])
	{
		NSLog(@"test.qtz failed to load");
        [NSApp terminate:nil];
	}
    
    NSLog(@"test.qtz has been loaded");
    
    //Previously, I was observing a QCPatchController instance, created in Interface Builder (which doesn't work for me anymore)
    //Actually, observing QCView directly is okay
    [qcView addObserver:self forKeyPath:@"patch.Count.value" options:NSKeyValueObservingOptionNew context:NULL];
    
    //Uncomment this line if the qc composition uses the mouse
    //[qcView setEventForwardingMask:NSAnyEventMask];

    
    
    [self toggleFullScreen];
}


- (void) observeValueForKeyPath:(NSString*)keyPath
					   ofObject:(id)object
						 change:(NSDictionary*)change
						context:(void*)context
{
    if ([keyPath isEqualToString:@"patch.Count.value"])
    {
        int val = [[qcView valueForOutputKey:@"Count"] intValue];
        NSLog(@"%@ = %d", keyPath, val);
    }
}


-(void)toggleFullScreen
{
    NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithBool:NO], NSFullScreenModeAllScreens,
                          [NSNumber numberWithInt:0], NSFullScreenModeWindowLevel,
                          [NSNumber numberWithInt:5], NSFullScreenModeApplicationPresentationOptions,nil];
                          [NSCursor hide];
    
    if([[self.window contentView] isInFullScreenMode])
    {
        [[self.window contentView] exitFullScreenModeWithOptions:nil];
        if (![qcView isRendering])
        {
            [qcView startRendering];
        }
    }
    else
    {
        [[self.window contentView] enterFullScreenMode:[NSScreen mainScreen] withOptions:opts];
        if (![qcView isRendering])
        {
            [qcView startRendering];
        }
    }
}

@end
