//
//  CNVenueList.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNVenueList.h"
#import "CNJSONParser.h"

@implementation CNVenueList

+ (id)sharedInstance {
	static dispatch_once_t predicate;
	static CNVenueList *instance = nil;
	dispatch_once(&predicate, ^{instance = [[self alloc] init];});
	return instance;
}

-(id)init
{
    if ((self = [super init]))
    {
        [CNJSONParser parseArrayFromJSON: ^(NSArray *inArray)
         {
             self.venueList = [NSArray arrayWithArray: inArray];
             DLog(@"Made venue list, count is %i", _venueList.count);
         }];
    }
    return self;
}

@end
