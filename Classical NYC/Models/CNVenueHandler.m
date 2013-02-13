//
//  CNVenueList.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNVenueHandler.h"
#import "CNJSONHandler.h"

@implementation CNVenueHandler

+ (id)sharedInstance {
	static dispatch_once_t predicate;
	static CNVenueHandler *instance = nil;
	dispatch_once(&predicate, ^{instance = [[self alloc] init];});
	return instance;
}

-(id)init
{
    if ((self = [super init]))
    {
        [CNJSONHandler parseArrayFromJSON: ^(NSArray *inArray)
         {
             self.venueList = [NSArray arrayWithArray: inArray];
             DLog(@"Made venue list, count is %i", _venueList.count);
         }];
    }
    return self;
}

@end
