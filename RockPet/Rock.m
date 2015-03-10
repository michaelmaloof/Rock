//
//  Rock.m
//  RockPet
//
//  Created by Michael Maloof on 3/8/15.
//  Copyright (c) 2015 Michael Maloof. All rights reserved.
//

#import "Rock.h"

static float const petFrequency = 25;  // in seconds

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


- (void)allowRockPetting{
    if(self.age >= 5 )
    {
        self.canPetRock = YES;
    }
}

-(void)rockSpeaks
{
    [self performSelector:@selector(allowRockPetting) withObject:nil afterDelay:petFrequency];
}













#pragma Notifications

-(void)createLetterANotification{
    
    //The rock will send the letter "A". He is learning the alphabet
    
    if(self.hasSentA == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:86400];
        localNotification.alertBody = @"A";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.hasSentA = YES;
    }
}



-(void)createLetterBNotification{
    
    if(self.hasSentB == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:172800];
        localNotification.alertBody = @"B";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.hasSentB = YES;
    }
}

-(void)createLetterCDEFNotification{
    
    if(self.hasSentCDEF == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:259200];
        localNotification.alertBody = @"C D E F";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.hasSentCDEF = YES;
    }
}


-(void)createLetterGHIJNotification{
    
    if(self.hasSentGHIJ == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:345600];
        localNotification.alertBody = @"G H I J K L M N O P Q R S T U V W X Y";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.hasSentGHIJ = YES;
    }
}

-(void)createLetterZNotification{
    
    if(self.hasSentZ == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:432000];
        localNotification.alertBody = @"Z Z Z Z Z";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.hasSentZ = YES;
    }
}


@end
