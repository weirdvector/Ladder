//
//  ViewController.m
//  major_project
//
//  Created by iOS Xcode User on 2016-03-20.
//  Copyright © 2016 Muska Ahmadzai. All rights reserved.
//

/*
    Author: Muska Ahmadzai
    This is legacy code.
 
 */

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize loginBtn, registerOrgBtn, registerUserBtn, txtPassword, txtUsername;


-(IBAction)goToRegister:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [mainDelegate flipToRegister];
}

-(IBAction)goToOrganizationRegister:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [mainDelegate flipToOrgRegister];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginClick:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSLog(txtUsername.text);
    NSLog(txtPassword.text);
    if ([mainDelegate loginUser:txtUsername.text pw: txtPassword.text]) {
        [mainDelegate transToDash];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Failure." message:@"Login failed." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler: nil];
        [alert addAction:ok];
        [self presentViewController:alert animated: YES completion:nil];
    }
}

@end
