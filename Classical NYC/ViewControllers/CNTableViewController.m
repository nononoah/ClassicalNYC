//
//  CNTableViewController.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNTableViewController.h"
#import "CNVenueList.h"
#import "CNVenue.h"

@interface CNTableViewController ()

@end

@implementation CNTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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
    return VENUELIST.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	while (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
	}
    
    CNVenue *tmpVenue = [VENUELIST objectAtIndex: indexPath.row];
    cell.textLabel.text = tmpVenue.venueName;
    
    return cell;
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
