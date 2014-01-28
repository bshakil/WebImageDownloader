//
//  AppDelegate.m
//  WebsiteDownloader
//
//  Created by Burhan S Ahmed on 1/28/14.
//  Copyright (c) 2014 Burhan S Ahmed. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSError *error;

    // Determile cache file path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"index.html"];
    
    // Download and write to file
    NSURL *url = [NSURL URLWithString:@"http://www.modnique.com/saleevent/Women-s/White-Mark-All-35-Or-Less/16218/seeac/gseeac"];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    NSString *aStr = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
    //NSLog(@"aStr:%@",aStr);
    [urlData writeToFile:filePath atomically:YES];
    
    //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http?://llthumb([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?(\\jpg)" options:NSRegularExpressionCaseInsensitive error:&error];
   // NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"/product/Women/([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?" options:NSRegularExpressionCaseInsensitive error:&error];
   // NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" options:NSRegularExpressionCaseInsensitive error:&error];
    //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSString *urlRegEx = @"/product/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:aStr options:0 range:NSMakeRange(0, [aStr length])];
    
    NSMutableArray *arrayOfURLs = [[NSMutableArray alloc] init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
        NSString* substringForMatch = [aStr substringWithRange:match.range];
       // NSLog(@"%@",substringForMatch);
        
        [arrayOfURLs addObject:substringForMatch];
    }
    
    NSString *result = [[arrayOfURLs valueForKey:@"description"] componentsJoinedByString:@"\rwww.modnique.com"];

    NSString *new = [result stringByReplacingOccurrencesOfString:@"thumbs" withString:@"super"];

    NSLog(@"aStr:%@",new);
    // return non-mutable version of the array
   
    
 
}

@end
