//
//  DismissSegue.m
//  RockPet
//
//  Created by Michael Cannell on 3/6/15.
//  Copyright (c) 2015 Michael Maloof. All rights reserved.
//

#import "DismissSegue.h"

@implementation DismissSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end