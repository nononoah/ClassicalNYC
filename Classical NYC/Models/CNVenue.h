//
//  CNVenue.h
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNVenue : NSObject

@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, copy)   NSString *venueName;
@property (nonatomic, copy)   NSString *venueURL;
@property (nonatomic, copy)   NSString *venueStreetAddress;

@end
