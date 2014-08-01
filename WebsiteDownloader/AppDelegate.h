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
    NSString    *MainWebpageSource;
    
}
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *MainURL;
@property (weak) IBOutlet NSArrayController *URLarrayController;
@property (weak) IBOutlet NSTextField *SavePath;
@property (weak) IBOutlet NSTextField *FilterURL;
@property (weak) IBOutlet NSTextField *textSource;
@property (weak) IBOutlet NSTextField *RootURL;
@property (weak) IBOutlet NSTextField *ImageURLHelper;
@property (weak) IBOutlet NSTextField *ImageURLHelperEnd;
@property (weak) IBOutlet NSTextField *ImageRootURL;
@property (weak) IBOutlet NSTextField *FilterImageUrls;
@property (weak) IBOutlet NSTextField *SearchString;
@property (weak) IBOutlet NSTextField *ReplaceString;
@property (weak) IBOutlet NSComboBox *WebSiteSelector;

@end
