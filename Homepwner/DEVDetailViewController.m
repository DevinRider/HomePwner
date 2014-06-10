//
//  DEVDetailViewController.m
//  Homepwner
//
//  Created by Devin on 6/10/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVDetailViewController.h"
#import "DEVItem.h"

@interface DEVDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DEVDetailViewController

- (void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear:animated];
    DEVItem *item = self.item;

    self.nameField.text = item.itemName;
    self.serialField.text = item.serialNumber;
    self.valueField.text =[NSString stringWithFormat:@"%i", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //clear first responder
    [self.view endEditing:YES];
    
    DEVItem *item = self.item;
    
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(DEVItem *)item
{
    _item = item;
    self.navigationItem.title = item.itemName;
}

@end
