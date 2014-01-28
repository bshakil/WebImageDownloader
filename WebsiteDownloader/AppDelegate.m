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
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"index.html"];
    
    // Download and write to file
    NSURL *url = [NSURL URLWithString:@"http://www.modnique.com/saleevent/Women-s/White-Mark-All-35-Or-Less/16218/seeac/gseeac"];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    NSString *aStr = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
    //NSLog(@"aStr:%@",aStr);
    //[urlData writeToFile:filePath atomically:YES];
    
    //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http?://llthumb([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?(\\jpg)" options:NSRegularExpressionCaseInsensitive error:&error];
   // NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"/product/Women/([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?" options:NSRegularExpressionCaseInsensitive error:&error];
   // NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" options:NSRegularExpressionCaseInsensitive error:&error];
    //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSString *urlRegEx = @"/product/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:aStr options:0 range:NSMakeRange(0, [aStr length])];
    
    NSMutableArray *arrayOfURLs = [[NSMutableArray alloc] init];
    uniquearray= [[NSMutableArray alloc] init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
        NSString *substringForMatch = [aStr substringWithRange:match.range];
       // NSLog(@"%@",substringForMatch);
        NSString *stringURL=[NSString stringWithFormat:@"www.modnique.com%@",substringForMatch];
        [arrayOfURLs addObject:stringURL];
         uniquearray= [arrayOfURLs valueForKeyPath:@"@distinctUnionOfObjects.self"];
    }
    //Process Each URL
//    NSString *result;
//    for (id obj in uniquearray)
//    {
//        NSString *bstring =[NSString stringWithFormat:@"%@",obj];
//        NSURL *burl = [NSURL URLWithString:obj];
//        NSData *burlData = NULL;
//
//        while(burlData==NULL)
//        {
//            burlData = [NSData dataWithContentsOfURL:burl options:NSDataReadingUncached error:&error];
//            NSLog(@"content = %@", burlData);
//        }
//        NSString *bStr = [[NSString alloc] initWithData:burlData encoding:NSASCIIStringEncoding];
//        urlRegEx=@"http?://llthumb([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?(\\jpg)";
//        regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
//        arrayOfAllMatches = [regex matchesInString:aStr options:0 range:NSMakeRange(0, [aStr length])];
//        result = [[arrayOfAllMatches valueForKey:@"description"] componentsJoinedByString:@"\r"];
//        NSLog(@"aStr:%@",result);
//    }
    
    //NSString *result = [[uniquearray valueForKey:@"description"] componentsJoinedByString:@"\r"];
   // NSString *new = [result stringByReplacingOccurrencesOfString:@"thumbs" withString:@"super"];
    //NSLog(@"aStr:%@",new);
    // return non-mutable version of the array
 
}

- (IBAction)TestURL:(id)sender {
    imageurlarray = [[NSMutableArray alloc] init];
    NSString *result;
    NSError *error;
    for (id obj in uniquearray)
    {
        NSString *bstring =[NSString stringWithFormat:@"http://%@",obj];
        NSURL *burl = [NSURL URLWithString:bstring];
        NSData *burlData = NULL;
        
        while(burlData==NULL)
        {
            burlData = [NSData dataWithContentsOfURL:burl options:NSDataReadingUncached error:&error];
            
        }
        NSString *bStr = [[NSString alloc] initWithData:burlData encoding:NSASCIIStringEncoding];
        NSLog(@"content = %@", bStr);
        //NSString *urlRegEx=@"http?://llthumb([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?(\\jpg)";
       
         NSString *urlRegEx = @"http://llthumb.bids.com/mod/sales/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
        
        NSArray *arrayOfAllMatches = [regex matchesInString:bStr options:0 range:NSMakeRange(0, [bStr length])];
        
        for (NSTextCheckingResult *match in arrayOfAllMatches) {
            NSString *substringForMatch = [bStr substringWithRange:match.range];
            // NSLog(@"%@",substringForMatch);
            //NSString *stringURL=[NSString stringWithFormat:@"www.modnique.com%@",substringForMatch];
            [imageurlarray addObject:substringForMatch];
           
            //uniquearray= [arrayOfURLs valueForKeyPath:@"@distinctUnionOfObjects.self"];
        }

        
    }
    NSPredicate *sPredicate =
    [NSPredicate predicateWithFormat:@"SELF contains[c] 'super'"];
    [imageurlarray filterUsingPredicate:sPredicate];
    result = [[imageurlarray valueForKey:@"description"] componentsJoinedByString:@"\r"];
    NSLog(@"aStr:%@",result);
}
- (IBAction)DownloadImages:(id)sender {
     NSError *error;
    for (id obj in imageurlarray)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"index.jpg"];
        NSString *url =[NSString stringWithFormat:@"%@",obj];
        NSString *theFileName = [[url lastPathComponent] stringByDeletingPathExtension];
        NSURL *burl = [NSURL URLWithString:url];
        NSData *data = [NSData dataWithContentsOfURL:burl options:NSDataReadingUncached error:&error];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.jpg", [paths objectAtIndex:0],theFileName];
        [data writeToFile:filePath atomically:YES];
    }
}

@end
