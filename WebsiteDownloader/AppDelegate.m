//
//  AppDelegate.m
//  WebsiteDownloader
//
//  Created by Burhan S Ahmed on 1/28/14.
//  Copyright (c) 2014 Burhan S Ahmed. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (IBAction)GetPageSource:(id)sender
{
    NSURL *url = [NSURL URLWithString:self.MainURL.stringValue];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    MainWebpageSource = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
    self.textSource.stringValue=MainWebpageSource;
    //self.RootURL.stringValue=[url host];
    if ([[url host] isEqual:@"www.modnique.com"]) {
        self.RootURL.stringValue=[url host];
        self.FilterURL.stringValue=@"/product/Women/";
        self.ImageURLHelper.stringValue=@"http://";
        self.FilterImageUrls.stringValue=@"super";
    }
    if ([[url host] isEqual:@"www.amazon.com"]) {
        self.FilterURL.stringValue=@"www.amazon.com/";
        self.ImageURLHelper.stringValue=@"http://";
        self.ImageURLHelperEnd.stringValue=@".mp4";
    }
    if ([[url host] isEqual:@"www.ruelala.com"]) {
        self.RootURL.stringValue=[url host];
        self.FilterURL.stringValue=@"/event/product/";
        self.ImageURLHelper.stringValue=@"http://";
        self.SearchString.stringValue=@"RLLD_1.jpg";
        self.ReplaceString.stringValue=@"RLLZ_1.jpg";
        //self.ImageURLHelperEnd.stringValue=@".mp4";
    }
    //self.ImageRootURL.stringValue= [NSString stringWithFormat:@"http://%@",[url host]];
}

- (IBAction)GetChildURLs:(id)sender {
    NSRange range = NSMakeRange(0, [[_URLarrayController arrangedObjects] count]);
    [_URLarrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    NSError *error;
    NSString *urlRegEx = [NSString stringWithFormat:@"%@[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*",self.FilterURL.stringValue];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:MainWebpageSource options:0 range:NSMakeRange(0, [MainWebpageSource length])];
    NSMutableArray *arrayOfURLs = [[NSMutableArray alloc] init];
    uniquearray= [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString *substringForMatch = [MainWebpageSource substringWithRange:match.range];
        // NSLog(@"%@",substringForMatch);
        NSString *stringURL=[NSString stringWithFormat:@"%@%@",self.RootURL.stringValue,substringForMatch];
        [arrayOfURLs addObject:stringURL];
        uniquearray= [arrayOfURLs valueForKeyPath:@"@distinctUnionOfObjects.self"];
    }
    for (id obj in uniquearray)
    {
        [_URLarrayController addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"URLs" ,nil]];
    }
    self.textSource.stringValue=@"";
}


- (IBAction)GetImageSource:(id)sender {
    
    imageurlarray = [[NSMutableArray alloc] init];
    NSError *error;
    NSString *bstring =[NSString stringWithFormat:@"http://%@",[uniquearray objectAtIndex:0]];
    NSURL *burl = [NSURL URLWithString:bstring];
    NSData *burlData = NULL;
    burlData = [NSData dataWithContentsOfURL:burl options:NSDataReadingUncached error:&error];
    NSString *bStr = [[NSString alloc] initWithData:burlData encoding:NSASCIIStringEncoding];
    NSString *FixedURL=@"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*";
    NSString *urlRegEx=[NSString stringWithFormat:@"%@%@%@",self.ImageURLHelper.stringValue,FixedURL,self.ImageURLHelperEnd.stringValue];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:bStr options:0 range:NSMakeRange(0, [bStr length])];
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
            NSString *substringForMatch = [bStr substringWithRange:match.range];
            [imageurlarray addObject:substringForMatch];
        }
    //NSPredicate *sPredicate =
    //[NSPredicate predicateWithFormat:@"SELF contains[c] 'super'"];
    //[imageurlarray filterUsingPredicate:sPredicate];
    NSRange range = NSMakeRange(0, [[_URLarrayController arrangedObjects] count]);
    [_URLarrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    for (id obj in imageurlarray)
    {
        [_URLarrayController addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"URLs" ,nil]];
    }

}

- (IBAction)GetImageUrls:(id)sender {
    
    imageurlarray = [[NSMutableArray alloc] init];
    NSError *error;
    for (id obj in uniquearray)
    {
    NSString *bstring =[NSString stringWithFormat:@"http://%@",obj];
    NSURL *burl = [NSURL URLWithString:bstring];
    NSData *burlData = NULL;
        if (burl==nil) {
            
        }
        else
        {
    burlData = [NSData dataWithContentsOfURL:burl options:NSDataReadingUncached error:&error];
    NSString *bStr = [[NSString alloc] initWithData:burlData encoding:NSASCIIStringEncoding];
    NSString *FixedURL=@"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*";
    NSString *urlRegEx=[NSString stringWithFormat:@"%@%@%@",self.ImageURLHelper.stringValue,FixedURL,self.ImageURLHelperEnd.stringValue];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:bStr options:0 range:NSMakeRange(0, [bStr length])];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString *substringForMatch = [bStr substringWithRange:match.range];
        substringForMatch=[NSString stringWithFormat:@"%@%@",self.ImageRootURL.stringValue,substringForMatch];
        [imageurlarray addObject:substringForMatch];
    }
    }
   // NSString *ImageFilterURL=[NSString stringWithFormat:@"SELF contains[c] '%@'",self.FilterImageUrls.stringValue];
   // NSPredicate *sPredicate =
    //[NSPredicate predicateWithFormat:ImageFilterURL];
    //	[imageurlarray filterUsingPredicate:sPredicate];
    NSRange range = NSMakeRange(0, [[_URLarrayController arrangedObjects] count]);
    [_URLarrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    for (id obj in imageurlarray)
    {
    [_URLarrayController addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"URLs" ,nil]];
    }

    
//    imageurlarray = [[NSMutableArray alloc] init];
//    NSError *error;
//    for (id obj in uniquearray)
//    {
//        NSString *bstring =[NSString stringWithFormat:@"http://%@",obj];
//        NSURL *burl = [NSURL URLWithString:bstring];
//        NSData *burlData = NULL;
//        while(burlData==NULL)
//        {
//            burlData = [NSData dataWithContentsOfURL:burl options:NSDataReadingUncached error:&error];
//            
//        }
//        NSString *bStr = [[NSString alloc] initWithData:burlData encoding:NSASCIIStringEncoding];
//         NSString *urlRegEx = @"http://llthumb.bids.com/mod/sales/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*";
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
//        
//        NSArray *arrayOfAllMatches = [regex matchesInString:bStr options:0 range:NSMakeRange(0, [bStr length])];
//        
//        for (NSTextCheckingResult *match in arrayOfAllMatches) {
//            NSString *substringForMatch = [bStr substringWithRange:match.range];
//            [imageurlarray addObject:substringForMatch];
//        }
//    }
//    NSPredicate *sPredicate =
//    [NSPredicate predicateWithFormat:@"SELF contains[c] 'super'"];
//    [imageurlarray filterUsingPredicate:sPredicate];
//    NSRange range = NSMakeRange(0, [[_URLarrayController arrangedObjects] count]);
//    [_URLarrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
//    for (id obj in imageurlarray)
//    {
//        [_URLarrayController addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"URLs" ,nil]];
//    }
    }
    
}
- (IBAction)FilterImageURLs:(id)sender {
    NSString *ImageFilterURL=[NSString stringWithFormat:@"SELF contains[c] '%@'",self.FilterImageUrls.stringValue];
    NSPredicate *sPredicate =
    [NSPredicate predicateWithFormat:ImageFilterURL];
    [imageurlarray filterUsingPredicate:sPredicate];
    NSRange range = NSMakeRange(0, [[_URLarrayController arrangedObjects] count]);
    [_URLarrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    for (id obj in imageurlarray)
    {
        [_URLarrayController addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"URLs" ,nil]];
    }
}

- (IBAction)ModifyURLs:(id)sender {
    NSMutableArray *temp=[NSMutableArray arrayWithArray:imageurlarray];
    //temp=imageurlarray;
    NSString *searchstring=self.SearchString.stringValue;
    NSString *replacestring=self.ReplaceString.stringValue;
    [imageurlarray removeAllObjects];
    for (id obj in temp)
    {
        NSString *bstring =[NSString stringWithFormat:@"%@",obj];
        bstring = [bstring stringByReplacingOccurrencesOfString:searchstring withString:replacestring];
        [imageurlarray addObject:bstring];
    }
    NSRange range = NSMakeRange(0, [[_URLarrayController arrangedObjects] count]);
    [_URLarrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    for (id obj in imageurlarray)
    {
        [_URLarrayController addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"URLs" ,nil]];
    }
    
}


- (IBAction)DownloadImages:(id)sender {
    NSString *tvarDirectory;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSSavePanel *tvarNSSavePanelObj	= [NSSavePanel savePanel];
    NSInteger tvarInt	= [tvarNSSavePanelObj runModal];
    if(tvarInt == NSOKButton){
        tvarDirectory = [tvarNSSavePanelObj directory];
    }
    else
    {
        tvarDirectory = [paths objectAtIndex:0];
    }
    self.SavePath.stringValue=tvarDirectory;
    NSError *error;
    for (id obj in imageurlarray)
    {
        NSString *url =[NSString stringWithFormat:@"%@",obj];
       // NSString *theFileName   = [[url lastPathComponent] stringByDeletingPathExtension];
        NSString *theFileName   = [url lastPathComponent];
        NSURL *burl = [NSURL URLWithString:url];
        NSData *data = [NSData dataWithContentsOfURL:burl options:NSDataReadingUncached error:&error];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", tvarDirectory,theFileName];
        [data writeToFile:filePath atomically:YES];
    }
}
//Useless Code
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //    NSError *error;
    //
    //    // Determile cache file path
    //    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    //NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"index.html"];
    //
    //    // Download and write to file
    //    NSURL *url = [NSURL URLWithString:@"http://www.modnique.com/saleevent/Women-s/White-Mark-All-35-Or-Less/16218/seeac/gseeac"];
    //    NSData *urlData = [NSData dataWithContentsOfURL:url];
    //
    //    NSString *aStr = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
    //    //NSLog(@"aStr:%@",aStr);
    //    //[urlData writeToFile:filePath atomically:YES];
    //
    //    //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http?://llthumb([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?(\\jpg)" options:NSRegularExpressionCaseInsensitive error:&error];
    //   // NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"/product/Women/([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?" options:NSRegularExpressionCaseInsensitive error:&error];
    //   // NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" options:NSRegularExpressionCaseInsensitive error:&error];
    //    //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?" options:NSRegularExpressionCaseInsensitive error:&error];
    //
    //    NSString *urlRegEx = @"/product/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*";
    //
    //    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
    //
    //    NSArray *arrayOfAllMatches = [regex matchesInString:aStr options:0 range:NSMakeRange(0, [aStr length])];
    //
    //    NSMutableArray *arrayOfURLs = [[NSMutableArray alloc] init];
    //    uniquearray= [[NSMutableArray alloc] init];
    //
    //    for (NSTextCheckingResult *match in arrayOfAllMatches) {
    //        NSString *substringForMatch = [aStr substringWithRange:match.range];
    //       // NSLog(@"%@",substringForMatch);
    //        NSString *stringURL=[NSString stringWithFormat:@"www.modnique.com%@",substringForMatch];
    //        [arrayOfURLs addObject:stringURL];
    //         uniquearray= [arrayOfURLs valueForKeyPath:@"@distinctUnionOfObjects.self"];
    //    }
    //    //Process Each URL
    ////    NSString *result;
    ////    for (id obj in uniquearray)
    ////    {
    ////        NSString *bstring =[NSString stringWithFormat:@"%@",obj];
    ////        NSURL *burl = [NSURL URLWithString:obj];
    ////        NSData *burlData = NULL;
    ////
    ////        while(burlData==NULL)
    ////        {
    ////            burlData = [NSData dataWithContentsOfURL:burl options:NSDataReadingUncached error:&error];
    ////            NSLog(@"content = %@", burlData);
    ////        }
    ////        NSString *bStr = [[NSString alloc] initWithData:burlData encoding:NSASCIIStringEncoding];
    ////        urlRegEx=@"http?://llthumb([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?(\\jpg)";
    ////        regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:NSRegularExpressionCaseInsensitive error:&error];
    ////        arrayOfAllMatches = [regex matchesInString:aStr options:0 range:NSMakeRange(0, [aStr length])];
    ////        result = [[arrayOfAllMatches valueForKey:@"description"] componentsJoinedByString:@"\r"];
    ////        NSLog(@"aStr:%@",result);
    ////    }
    //
    //    //NSString *result = [[uniquearray valueForKey:@"description"] componentsJoinedByString:@"\r"];
    //   // NSString *new = [result stringByReplacingOccurrencesOfString:@"thumbs" withString:@"super"];
    //    //NSLog(@"aStr:%@",new);
    //    // return non-mutable version of the array
    
}

@end
