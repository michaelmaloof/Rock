//
//  Rock.m
//  RockPet
//
//  Created by Michael Maloof on 3/8/15.
//  Copyright (c) 2015 Michael Maloof. All rights reserved.
//

#import "Rock.h"

@implementation Rock



-(IBAction)rockWasTapped:(UITapGestureRecognizer *)sender
{
    if(self.hasRockLearnedToTalk == NO)
    {
        if(self.age >= 5)
        {
            self.hasRockLearnedToTalk = YES;
        }
    }
    
    if(self.hasRockLearnedToTalk == YES)
    {
        NSLog(@"sup");
        self.canPetRock = NO;
    }
    [self.delegate rockWasTapped:self];
}

-(void)loadFirstDateDefault
{
    //load users first date on the app and convert from string to date
    NSUserDefaults *firstDateDefault = [NSUserDefaults standardUserDefaults];
    NSString *firstDateString = [firstDateDefault stringForKey:@"firstDate"];
    if(firstDateString == (id)[NSNull null] || firstDateString.length == 0 ){
        [self setFirstDateDefault];
    }else{
        self.firstDate = [self.formatter dateFromString:firstDateString];
        NSLog(@"loaded first date = %@", self.firstDate);
    }
}

-(void)setFirstDateDefault
{
    //turn today's date into a string and save it
    //The firstDate won't persist using NSUserDefaults. If the user deletes the app
    //and then reinstalls, they will need to start over at 40 X 40
    //If you want the firstDate to persist through deletes, use the keychain
    self.firstDate = [NSDate date];
    NSString *stringFromDate = [self.formatter stringFromDate:self.firstDate];
    NSUserDefaults *firstDateDefault = [NSUserDefaults standardUserDefaults];
    [firstDateDefault setObject: stringFromDate forKey:@"firstDate"];
    NSLog(@"saved first date = %@", self.firstDate);
}

-(void)setRockAge
{
    //find time between user's first date and today
    self.daysSinceFirstDate = [[NSDate date] timeIntervalSinceDate:self.firstDate]/86400;
    self.age = (int)roundf(self.daysSinceFirstDate);
}



@end
