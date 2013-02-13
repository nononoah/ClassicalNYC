//
//  CNJSONParser.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNJSONHandler.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "CNVenue.h"

@implementation CNJSONHandler


+ (void) fetchArrayFromJSON: (void (^)(NSArray *inArray)) inSuccessBlock
{
    NSURL *tmpUrl = [NSURL URLWithString:@"https://nycopendata.socrata.com/api/views/txxa-5nhg/rows.json"];
    NSURLRequest *tmpRequest = [NSURLRequest requestWithURL:tmpUrl];
    
    AFJSONRequestOperation *tmpOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:tmpRequest success:^(NSURLRequest *tmpRequest, NSHTTPURLResponse *response, id JSON) {
        NSArray *unparsedArray = [NSArray arrayWithArray: [JSON valueForKey:@"data"]];
        inSuccessBlock(unparsedArray);
    } failure:nil];
    
    NSOperationQueue *tmpQueue = [[NSOperationQueue alloc] init];
    [tmpQueue addOperation: tmpOperation];
}

+ (void) parseArrayFromJSON: (void (^)(NSArray *inArray)) inSuccessBlock
{
    NSMutableArray *tmpMutableArray = [NSMutableArray array];
    [CNJSONHandler fetchArrayFromJSON: ^(NSArray *inArray) {
       // DLog(@"Grabbed array, looks like: %@", inArray);
        
        //parse JSON by making objects and adding those objects to an array
        for (int i = 0; i < inArray.count; ++i)
        {
            CNVenue *tmpVenue = [[CNVenue alloc] init];
            tmpVenue.latitude = [[[inArray objectAtIndex: i] objectAtIndex: 9] objectAtIndex: 1];
            tmpVenue.longitude = [[[inArray objectAtIndex: i] objectAtIndex: 9] objectAtIndex: 2];
            tmpVenue.venueName = [[inArray objectAtIndex: i] objectAtIndex: 10];
            tmpVenue.venueURL = [[inArray objectAtIndex: i] objectAtIndex: 12];
            tmpVenue.venueStreetAddress = [[inArray objectAtIndex: i] objectAtIndex: 13];
            //DLog(@"tmpVenue lat = %@,\n lon = %@,\n name = %@,\n url = %@,\n address = %@", tmpVenue.latitude, tmpVenue.longitude, tmpVenue.venueName, tmpVenue.venueURL, tmpVenue.venueStreetAddress);
            
            [tmpMutableArray addObject: tmpVenue];
            [tmpVenue release];
        }
        inSuccessBlock(tmpMutableArray);
    }];
    
}

@end
