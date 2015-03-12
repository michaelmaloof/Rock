//
//  Rock.m
//  RockPet
//
//  Created by Michael Maloof on 3/8/15.
//  Copyright (c) 2015 Michael Maloof. All rights reserved.
//

#import "Rock.h"

static float const petFrequency = 25;  // in seconds
static float const minimumTalkAge = 5; //in days
static float const alphabetAge1 = 1; //in days
static float const alphabetAge2 = 2; //in days
static float const alphabetAge3 = 3; //in days
static float const alphabetAge4 = 4; //in days
static float const alphabetAge5 = 5; //in days

@interface Rock()

@end

@implementation Rock

-(IBAction)rockWasTapped:(UITapGestureRecognizer *)sender
{
    if(self.hasRockLearnedToTalk)
    {
        NSLog(@"sup");
        self.canPetRock = NO;
    }
    else
    {
        if(self.age >= minimumTalkAge)
        {
            self.hasRockLearnedToTalk = YES;
        }
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
    if(self.age >= minimumTalkAge )
    {
        self.canPetRock = YES;
    }
}

-(void)rockSpeaks
{
    [self performSelector:@selector(allowRockPetting) withObject:nil afterDelay:petFrequency];
}



#pragma mark - Notifications

-(void)createLetterANotification{
    
    //The rock will send the letter "A". He is learning the alphabet
    
    if(!self.hasSentA)
    {
        [[UIApplication sharedApplication] scheduleLocalNotification:[self createLocalNotificationWithText:@"A" andFireDate:[self timeIntervalInSecondsWithDays:alphabetAge1]]];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.hasSentA = YES;
    }
}


#warning - We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.

-(void)createLetterBNotification{
    
    if(!self.hasSentB) {
        [[UIApplication sharedApplication] scheduleLocalNotification:[self createLocalNotificationWithText:@"B" andFireDate:[self timeIntervalInSecondsWithDays:alphabetAge2]]];
        self.hasSentB = YES;
    }
}

-(void)createLetterCDEFNotification{
    
    if(!self.hasSentCDEF) {
        [[UIApplication sharedApplication] scheduleLocalNotification:[self createLocalNotificationWithText:@"C D E F" andFireDate:[self timeIntervalInSecondsWithDays:alphabetAge3]]];
        self.hasSentCDEF = YES;
    }
}


-(void)createLetterGHIJNotification{
    
    if(!self.hasSentGHIJ) {
        [[UIApplication sharedApplication] scheduleLocalNotification:[self createLocalNotificationWithText:@"G H I J K L M N O P Q R S T U V W X Y" andFireDate:[self timeIntervalInSecondsWithDays:alphabetAge4]]];
        self.hasSentGHIJ = YES;
    }
}

-(void)createLetterZNotification{
    
    if(!self.hasSentZ) {
        [[UIApplication sharedApplication] scheduleLocalNotification:[self createLocalNotificationWithText:@"Z Z Z Z Z" andFireDate:[self timeIntervalInSecondsWithDays:alphabetAge5]]];
        self.hasSentZ = YES;
    }
}

-(UILocalNotification *)createLocalNotificationWithText:(NSString *)message andFireDate:(int)timeInterval
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    localNotification.alertBody = message;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    return localNotification;
}

-(int)timeIntervalInSecondsWithDays:(int)days{
    return 60*60*24*days;
}



@end
