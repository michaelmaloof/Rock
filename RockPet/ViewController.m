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
static float const minimumDisplayAge = 12; //in days
static float const minimumSettingsAge = 15; //in days
static float const minimumTalkAge = 5; //in days

@interface ViewController ()

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
    if(self.rock.age >= minimumDisplayAge)
    {
        NSString *day = @"days";
        self.ageDisplay.text = [NSString stringWithFormat:@"I is %i %@ old",self.rock.age,day];
        self.ageDisplay.hidden = NO;
    }
}

-(void)updateSettingsLabel
{
    if(self.rock.age >= minimumSettingsAge)
    {
        self.settingsLabel.hidden = NO;
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


#pragma mark - Memory Warnings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Notifications
-(void)askNotificationPermission{
    
    //We won't ask for permission until the rock is 5. Is there anyway to change how we word it? We should tell the user Rock has learned to talk and thus we need notification permission
    
    if (self.rock.age >= minimumTalkAge) {
    
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
    //What if the user doesn't accept notifications and then goes into the settings and accepts? Then these methods below wont trigger? Or will they?
    //I don't think so, so, MAYBE, onViewWillAppear we check if the notifications have been created, if not, check if notifications have been approved, if so, then create the notifications
    
        [self.rock createLetterANotification];
        [self.rock createLetterBNotification];
        [self.rock createLetterCDEFNotification];
        [self.rock createLetterGHIJNotification];
        [self.rock createLetterZNotification];
        
    }
}







@end
