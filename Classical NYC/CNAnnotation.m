//
//  CNPinView.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNAnnotation.h"

@implementation CNAnnotation

- (id) initWithCoordinate: (CLLocationCoordinate2D) inCoordinate andTitle: (NSString *) inTitle andSubtitle: (NSString *) inSubtitle
{
    self = [super init];
    if (self) {
        self.coordinate = inCoordinate;
        self.title = inTitle;
        self.subtitle = inSubtitle;
    
    }
    return self;
}


- (void) dealloc
{
    [super dealloc];
}
@end
