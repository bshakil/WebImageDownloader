//
//  AppDelegate.h
//  WebsiteDownloader
//
//  Created by Burhan S Ahmed on 1/28/14.
//  Copyright (c) 2014 Burhan S Ahmed. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
@private
	NSMutableArray *uniquearray;
    NSMutableArray *imageurlarray;
    
}
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *MainURL;
@property (weak) IBOutlet NSArrayController *URLarrayController;
@property (weak) IBOutlet NSTextField *SavePath;

@end
