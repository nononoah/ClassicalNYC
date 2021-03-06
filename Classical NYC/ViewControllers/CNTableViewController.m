//
//  CNTableViewController.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNTableViewController.h"
#import "CNVenueHandler.h"
#import "CNVenue.h"
#import "CNMapViewController.h"
#import "CNButton.h"

@interface CNTableViewController ()
{
    BOOL _emptyFlag;
}
@end

@implementation CNTableViewController


- (id)init
{
    self = [super initWithStyle: UITableViewStylePlain];
    if (self) {
        self.title = @"List";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (VENUELIST.count == 0)
    {
        _emptyFlag = YES;
        return 1;
    }
    
    else
    {
        _emptyFlag = NO;
        return VENUELIST.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	while (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
	}
    
    if (_emptyFlag)
    {
        cell.textLabel.text = @"Tap to refresh";
        UIButton *tmpButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [tmpButton setBackgroundColor: [UIColor clearColor]];
        [tmpButton setFrame: CGRectMake (0, 0, 320, 30)];
        [cell addSubview: tmpButton];
        [tmpButton addTarget: self action: @selector(refreshData:) forControlEvents: UIControlEventAllTouchEvents];
    }
    
    else
    {
        CNVenue *tmpVenue = [VENUELIST objectAtIndex: indexPath.row];
        //UIFont *tmpFont = [UIFont fontWithName: @"Helvetica" size: 12.0];
        //[cell.textLabel setFont: tmpFont];
        [cell.textLabel setText: tmpVenue.venueName];
       
        //add accessory view button to see on map
        CNButton *tmpMapVenueButton = [CNButton buttonWithType: UIButtonTypeCustom];
        tmpMapVenueButton.foundInRow = indexPath.row;
        [tmpMapVenueButton setTitle: @"MAP" forState: UIControlStateNormal];
        tmpMapVenueButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [tmpMapVenueButton setBackgroundColor: [UIColor greenColor]];
        [tmpMapVenueButton setFrame: CGRectMake(0, 0, 30, 30)];
        [tmpMapVenueButton addTarget: self action: @selector(showVenueOnMap:) forControlEvents: UIControlEventTouchUpInside];
        [cell setAccessoryView: tmpMapVenueButton];
    }
    return cell;
}

- (void) showVenueOnMap: (CNButton *) inSender
{
    //set up controller and its mapview
    CNMapViewController *tmpController = [[CNMapViewController alloc] init];
    CLLocationCoordinate2D tmpCenter = {40.7142, -74.006}; //latitude, longitude
    MKCoordinateSpan tmpSpan = {.2, .2}; //degrees of lat and long span includes
    MKCoordinateRegion tmpRegion = {tmpCenter, tmpSpan}; //region sets default location and zoom for map when it opens
    tmpController.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    tmpController.mapView.region = tmpRegion;
    tmpController.mapView.showsUserLocation = YES;
    tmpController.mapView.delegate = tmpController;
    
    
    [self.navigationController pushViewController: tmpController animated: YES];
    //clear loading annotation, add annotation to this mapview
    [tmpController clearMapViewAndAnnotateUsing: [VENUELIST objectAtIndex: inSender.foundInRow]];
    
    [tmpController release];
}

- (void) refreshData: (UIButton *) inSender
{
    [inSender removeFromSuperview];
    [self.tableView reloadData];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CNVenue *tmpVenue = [VENUELIST objectAtIndex: indexPath.row];
   
    UIWebView *tmpWebView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, 320, 480)];
    NSURL *tmpWebUrl = [NSURL URLWithString: tmpVenue.venueURL];
    NSURLRequest *tmpRequest = [NSURLRequest requestWithURL: tmpWebUrl];
    [tmpWebView loadRequest: tmpRequest];
    tmpWebView.scalesPageToFit = YES;
    
    UIViewController *tmpController = [[UIViewController alloc] init];
    [tmpController.view addSubview: tmpWebView];
    tmpController.title =  tmpVenue.venueName;
    
    [self.navigationController pushViewController: tmpController animated: YES];
}

@end
