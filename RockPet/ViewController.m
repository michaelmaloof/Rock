//
//  ViewController.m
//  RockPet
//
//  Created by Michael Maloof on 11/18/14.
//  Copyright (c) 2014 Michael Maloof. All rights reserved.
//

#import "ViewController.h"
#import "Rock.h"


static float const initialWidth = 40;  // in pixels
static float const initialHeight = 40; // in pixels
static float const petFrequency = 25;  // in seconds

@interface ViewController () <RockDelegate>

@property Rock *rock;
@property (strong, nonatomic) IBOutlet UILabel *ageDisplay;
@property (weak, nonatomic) IBOutlet UIButton *settingsLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rockHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rockWidth;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rock.delegate = self;
    
    //Settings button isn't unlocked at first
    self.settingsLabel.hidden = YES;
    
    self.ageDisplay.hidden = YES;
    //age display isn'y unlocked until rock can write well
    
    //Use NSLocalizedString to handle multiple languages
    //self.title = NSLocalizedString(@"sup","sup");
    
    //set date format to year, month, and day
    self.rock.formatter = [[NSDateFormatter alloc] init];
    [self.rock.formatter setDateFormat: @"yyyy-MM-dd"];
    
    //Rather than load a boolen value to see if the user has run the app before,
    //just load the first date and check for nil. If nil, it hasn't been run before,
    //so, save the current date as the first date and continue
    [self.rock loadFirstDateDefault];
    
    //This should be cleaned up so setAge isn't dependant on adjustRockSize
    [self.rock setRockAge];
    
    //Adjust the size of the rock from the initial width and height based on
    //your timeInterval that you already wrote.
    [self adjustRockSize];
    
    //Update Age display at bottom of view
    [self updateDisplay];
    
    [self updateSettingsLabel];
    
    [self askNotificationPermission];
    
}

#pragma mark - Methods

-(void)adjustRockSize
{
    //perform size adjustment
    self.rockWidth.constant = [self updateRockWidth];
    self.rockHeight.constant = [self updateRockHeight];
}

-(void)updateDisplay
{
    if(self.rock.age >= 12)        
    {
    NSString *day = @"days";
    self.ageDisplay.text = [NSString stringWithFormat:@"I is %i %@ old",self.rock.age,day];
    self.ageDisplay.hidden = NO;
    }
}

#pragma mark - Calculations
-(float)updateRockWidth
{
    return initialWidth + self.rock.age;
}

-(float)updateRockHeight
{
    return initialHeight + self.rock.age;
}

#pragma mark - tap gesture recognizer


- (void) allowRockPetting{
    if(self.rock.age >= 5 )
    {
        self.rock.canPetRock = YES;
    }
}

#pragma mark - Memory Warnings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)updateSettingsLabel
{
    if(self.rock.age >= 15)
    {
        self.settingsLabel.hidden = NO;
    }
}

-(void)askNotificationPermission{
    
    //We won't ask for permission until the rock is 5. Is there anyway to change how we word it? We should tell the user Rock has learned to talk and thus we need notification permission
    
    if (self.rock.age >= 5) {
    
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
    //What if the user doesn't accept notifications and then goes into the settings and accepts? Then these methods below wont trigger? Or will they?
    
        [self createLetterANotification];
        [self createLetterBNotification];
        [self createLetterCDEFNotification];
        [self createLetterGHIJNotification];
        [self createLetterZNotification];
        
    }
}

-(void)createLetterANotification{
    
    //The rock will send the letter "A". He is learning the alphabet
    
    if(self.rock.hasSentA == NO) {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:86400];
    localNotification.alertBody = @"A";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
    //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
    self.rock.hasSentA = YES;
    }
}



-(void)createLetterBNotification{
    
    if(self.rock.hasSentB == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:172800];
        localNotification.alertBody = @"B";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.rock.hasSentB = YES;
    }
}

-(void)createLetterCDEFNotification{
    
    if(self.rock.hasSentCDEF == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:259200];
        localNotification.alertBody = @"C D E F";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.rock.hasSentCDEF = YES;
    }
}


-(void)createLetterGHIJNotification{
    
    if(self.rock.hasSentGHIJ == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:345600];
        localNotification.alertBody = @"G H I J K L M N O P Q R S T U V W X Y";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.rock.hasSentGHIJ = YES;
    }
}

-(void)createLetterZNotification{
    
    if(self.rock.hasSentZ == NO) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:432000];
        localNotification.alertBody = @"Z Z Z Z Z";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //We need to save these boolean values. Ideally we use core data and save the Rock class which will have all these boolean datas.
        self.rock.hasSentZ = YES;
    }
}

-(void)rockWasTapped:(Rock*)sender
{
    [self performSelector:@selector(allowRockPetting) withObject:nil afterDelay:petFrequency];
}





@end
