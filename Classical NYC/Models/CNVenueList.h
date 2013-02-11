//
//  CNVenueList.h
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNVenueList : NSObject

@property (nonatomic, retain) NSArray *venueList;
+ (id)sharedInstance;

@end
