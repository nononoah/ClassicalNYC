//
//  CNMapView.h
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CNMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, assign) MKMapView *mapView;
@property (nonatomic, assign) NSMutableArray *annotationArray;

- (void) clearMapViewAndAnnotateUsing: (NSArray *) inArray;

@end
