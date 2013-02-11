//
//  CNJSONParser.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNJSONParser.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "CNVenue.h"

@implementation CNJSONParser


+ (void) fetchArrayFromJSON: (void (^)(NSArray *inArray)) inSuccessBlock
{
    NSURL *url = [NSURL URLWithString:@"https://nycopendata.socrata.com/api/views/txxa-5nhg/rows.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *unparsedArray = [NSArray arrayWithArray: [JSON valueForKey:@"data"]];
        inSuccessBlock(unparsedArray);
    } failure:nil];
    
    [operation start];
}

+ (void) parseArrayFromJSON: (void (^)(NSArray *inArray)) inSuccessBlock
{
    NSMutableArray *tmpMutableArray = [NSMutableArray array];
    [CNJSONParser fetchArrayFromJSON: ^(NSArray *inArray) {
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
