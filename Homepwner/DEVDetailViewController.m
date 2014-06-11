//
//  DEVDetailViewController.m
//  Homepwner
//
//  Created by Devin on 6/10/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVDetailViewController.h"
#import "DEVItem.h"
#import "DEVImageStore.h"

@interface DEVDetailViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

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
    
    _imageView.image = [[DEVImageStore sharedStore] imageForKey:item.itemKey];
    
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}
- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [self presentViewController:imagePicker
                       animated:YES
                     completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.imageView.image = image;
    
    [[DEVImageStore sharedStore] setImage:image
                                   forKey:self.item.itemKey];
    [self dismissViewControllerAnimated:YES
                             completion:NULL];
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
- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)setItem:(DEVItem *)item
{
    _item = item;
    self.navigationItem.title = item.itemName;
}

@end
