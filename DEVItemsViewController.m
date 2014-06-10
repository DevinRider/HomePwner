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

@interface DEVItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation DEVItemsViewController

//designated initializer. Always makes the UITableViewStyle a plain one.
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if(self){

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
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
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

- (UIView *)headerView
{
    //if you have not loaded the headerview yet...
    if(!_headerView)
    {
        //load HeaderView.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }
    
    return _headerView;
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

- (IBAction)toggleEditingMode:(id)sender
{
    if(!self.editing){
        [sender setTitle:@"Done"
                forState:UIControlStateNormal];
        self.editing = true;
    }
    else{
        [sender setTitle:@"Edit"
                forState:UIControlStateNormal];
        self.editing = false;
    }
}

@end
