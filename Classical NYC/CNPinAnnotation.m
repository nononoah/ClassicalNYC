//
//  CNPinView.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNPinAnnotation.h"

@implementation CNPinAnnotation

- (id) initWithCoordinate: (CLLocationCoordinate2D) inCoordinates andTitle: (NSString *) inTitle
{
    self.latitude = inCoordinates.latitude;
    self.longitude = inCoordinates.longitude;
    return self;
}
@end
