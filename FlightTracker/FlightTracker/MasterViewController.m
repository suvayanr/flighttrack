//
//  MasterViewController.m
//  FlightTracker
//
//  Created by Suvayan Roy on 12/30/16.
//  Copyright © 2016 Suvayan Roy. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CCell.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self addfromTripit];
    
    
}

NSArray* arraytoinsert = nil;

-(void)addfromTripit {
    // do a thing
    NSString *info = [NSString stringWithFormat:@"AA|4406|DCA|C|35|2016-12-30|19:30:00|2016-12-30|19:30:00|2016-12-30|19:44:00|JFK|31A|2016-12-30|20:56:00|2016-12-30|20:56:00|2016-12-30|21:51:00|E75|1\nDL|123|CDG|||2017-01-10|12:10:00|||||ORD||2017-01-10|14:59:00|||||76W|0\nDL|1368|LGA|||2017-02-16|14:47:00|||||DTW||2017-02-16|16:57:00|||||M88|0\nDL|134|DTW|||2017-02-16|18:07:00|||||AMS||2017-02-17|08:00:00|||||333|0\nKL|1975|AMS|||2017-02-17|10:05:00|||||BUD||2017-02-17|12:05:00|||||73J|0\nKL|1972|BUD|||2017-02-21|06:30:00|||||AMS||2017-02-21|08:45:00|||||73H|0\nDL|137|AMS|||2017-02-21|13:00:00|||||DTW||2017-02-21|16:01:00|||||333|0\nDL|582|DTW|||2017-02-21|17:30:00|||||LGA||2017-02-21|19:23:00|||||M88|0"];
    NSLog(@"%@", info);
    NSArray *valsold = [info componentsSeparatedByString:@"\n"];
    NSArray* vals = [[valsold reverseObjectEnumerator] allObjects];
    NSLog(@"%@", vals);
    for (id row in vals) {
        NSArray *stringArray = [row componentsSeparatedByString: @"|"];
        arraytoinsert = stringArray;
        [self insertNewObjectTripIt:arraytoinsert];
        //[self insertNewObject:arraytoinsert];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObjectTripIt:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:arraytoinsert atIndex:0];
    //[self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"using new method");
}


NSArray* manualarraytoinsert = nil;

NSInteger addedmanualcounter = 0;

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    addedmanualcounter = addedmanualcounter + 1;
    //[self.objects insertObject:manualarraytoinsert atIndex:self.objects.count];
    //to prevent errors until add capability is established use the line below
    [self.objects insertObject:arraytoinsert atIndex:self.objects.count];
    //[self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:addedmanualcounter-1 inSection:1];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"using old method");
    
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *object = self.objects[indexPath.row];
        NSLog(@"%@", object);
        //NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.objects.count;
    if (section==0)
    {
        return self.objects.count-addedmanualcounter;
    }
    else{
        return addedmanualcounter;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0)
        return @"Tripit Flights";
    else
        return @"Manual Flights";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CCell *cell = (CCell *)[tableView dequeueReusableCellWithIdentifier:@"itemCellIdentifier" forIndexPath:indexPath];
    
    NSArray *object = self.objects[indexPath.row];
    //NSDate *object = self.objects[indexPath.row];
    //cell.textLabel.text = [object description];
    NSString *display = [NSString stringWithFormat:@"%@ %@\n%@ → %@", object[0], object[1], object[2],object[11]];
    NSString *display2 = [NSString stringWithFormat:@"↑%@ ↓%@", [object[6] substringToIndex:5], [object[14] substringToIndex:5]];
    cell.textLabel.numberOfLines = 0;
    //cell.label1.text = display;
    cell.textLabel.text = display;
    cell.label2.text = object[5];
    cell.detailTextLabel.text = display2;
    

    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
