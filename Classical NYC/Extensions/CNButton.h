//
//  CNButton.h
//  Classical NYC
//
//  Created by Noah Blake on 2/13/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNButton : UIButton
//used to map from tablecell in CNTableViewController
@property int foundInRow;

//used to pass pin location to get directions in CNNearby
@property double passingLatitude;
@property double passingLongitude;
@property (nonatomic, copy) NSString *passingName;

@end
