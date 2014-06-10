//
//  DEVItemsViewController.m
//  Homepwner
//
//  Created by Devin on 6/9/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVItemsViewController.h"
#import "DEVItemStore.h"
#import "DEVItem.h"
#import "DEVDetailViewController.h"

@interface DEVItemsViewController ()

@end

@implementation DEVItemsViewController

//designated initializer. Always makes the UITableViewStyle a plain one.
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if(self){
      //  UINavigationItem *navItem = self.navigationItem;
        self.navigationItem.title = @"Homepwner";
        
        //create a new bar button item that will send
        //addNewItem: to DEVItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewItem:)];
        
        //set this bar item as the right item in the navigationItem
        self.navigationItem.rightBarButtonItem = bbi;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

//don't care what style is given, this uses a plain one.
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DEVItemStore sharedStore] allItems] count];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    //set the text on the cell witht he description of the item that is located at the nth index
    //where n = row this cell will appear on in the tableview
    NSArray *items = [[DEVItemStore sharedStore] allItems];
    DEVItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if the table view is asking to commit a delete command...
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSArray *items = [[DEVItemStore sharedStore] allItems];
        DEVItem *item = items[indexPath.row];
        
        [[DEVItemStore sharedStore] removeItem:item];
        
        //also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[DEVItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEVDetailViewController *detailViewController = [[DEVDetailViewController alloc] init];
 
    NSArray *items = [[DEVItemStore sharedStore] allItems];
    DEVItem *selectedItem = items[indexPath.row];
    
    detailViewController.item = selectedItem;
    
    //push it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (IBAction)addNewItem:(id)sender
{
    DEVItem *newItem = [[DEVItemStore sharedStore] createItem];
    
    //make a new index path for the 0th section, last row
    NSInteger lastRow = [[[DEVItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow
                                                inSection:0];
    
    //insert this new row into the table
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}

@end
