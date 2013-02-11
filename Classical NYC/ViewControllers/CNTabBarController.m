//
//  CNTabBarController.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNTabBarController.h"
#import "CNTableViewController.h"
#import "CNMapView.h"


@interface CNTabBarController ()

@end

@implementation CNTabBarController

- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *tmpMutableArray = [[NSMutableArray alloc] init];
        NSArray *tmpArray = [NSArray arrayWithObjects: @"List", @"Map", @"What's Close?",  nil];
        int i = 0;
        
		for (Class tmpClass in @[[CNTableViewController class], [CNMapView class], [UIViewController class]])
		{
			UINavigationController *tmpNavController = [[UINavigationController alloc] initWithRootViewController:[[[tmpClass alloc] init] autorelease]];
            tmpNavController.title = [tmpArray objectAtIndex: i];
			[tmpMutableArray addObject:tmpNavController];
			[tmpNavController release];
            i++;
		}
        
        [self setViewControllers: tmpMutableArray];
        [tmpMutableArray release];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
