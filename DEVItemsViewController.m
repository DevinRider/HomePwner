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

@implementation DEVItemsViewController

//designated initializer. Always makes the UITableViewStyle a plain one.
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if(self){
        for (int i = 0; i < 5; i++) {
            [[DEVItemStore sharedStore] createItem];
        }
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

@end
