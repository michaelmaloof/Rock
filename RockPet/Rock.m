//
//  Rock.m
//  RockPet
//
//  Created by Michael Maloof on 3/8/15.
//  Copyright (c) 2015 Michael Maloof. All rights reserved.
//

#import "Rock.h"

@implementation Rock



-(IBAction)rockWasTapped:(UITapGestureRecognizer *)sender {
    [self.delegate rockWasTapped:self];
}





@end
