//
//  BUNAppDelegate.h
//  qcViewSample
//
//  Created by JFR on 13/12/2013.
//  Copyright (c) 2013 JFR. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface BUNAppDelegate : NSObject <NSApplicationDelegate>
{
    QCView * qcView;
}
@property (assign) IBOutlet NSWindow *window;

-(void)toggleFullScreen;

@end
