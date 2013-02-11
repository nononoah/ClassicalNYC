//
//  CNJSONParser.h
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNJSONParser : NSObject

+ (void) fetchArrayFromJSON: (void (^)(NSArray *inArray)) inSuccessBlock;
+ (void) parseArrayFromJSON: (void (^)(NSArray *inArray)) inSuccessBlock;
@end
