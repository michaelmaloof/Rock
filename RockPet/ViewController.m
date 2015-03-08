//
//  ViewController.m
//  RockPet
//
//  Created by Michael Maloof on 11/18/14.
//  Copyright (c) 2014 Michael Maloof. All rights reserved.
//

#import "ViewController.h"


static float const initialWidth = 40;  // in pixels
static float const initialHeight = 40; // in pixels
static float const petFrequency = 25;  // in seconds

@interface ViewController ()

@property NSDate *firstDate;
@property NSDateFormatter *formatter;
@property float daysSinceFirstDate;
@property (weak, nonatomic) IBOutlet UIImageView *rock;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rockHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rockWidth;
@property (strong, nonatomic) IBOutlet UILabel *ageDisplay;
@property (nonatomic) BOOL canPetRock;
@property int age;
@property (weak, nonatomic) IBOutlet UIButton *settingsLabel;
@property bool hasSentA;
@property bool hasSentB;
@property bool hasSentCDEF;
@property bool hasSentGHIJ;
@property bool hasSentZ;

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
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat: @"yyyy-MM-dd"];
    
    //Rather than load a boolen value to see if the user has run the app before,
    //just load the first date and check for nil. If nil, it hasn't been run before,
    //so, save the current date as the first date and continue
    [self loadFirstDateDefault];
    
    //Adjust the size of the rock from the initial width and height based on
    //your timeInterval that you already wrote.
    [self adjustRockSize];
    
    //This should be cleaned up so setAge isn't dependant on adjustRockSize
    [self setRockAge];
    
    //Update Age display at bottom of view
    [self updateDisplay];
    
    [self updateSettingsLabel];
    
    [self askNotificationPermission];
    
}

#pragma mark - Methods
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

-(void)adjustRockSize
{
    //find time between user's first date and today
    self.daysSinceFirstDate = [[NSDate date] timeIntervalSinceDate:self.firstDate]/86400;
    NSLog(@"Rock is %f day(s) old", self.daysSinceFirstDate);
    
    //perform size adjustment
    self.rockWidth.constant = [self updateRockWidth];
    self.rockHeight.constant = [self updateRockHeight];
}

-(void)updateDisplay{
    NSLog(@"age of rock at display %d", self.age);
    if(self.age >= 12) {
    NSString *day = @"days";
        
    self.ageDisplay.text = [NSString stringWithFormat:@"I is %i %@ old",self.age,day];
    self.ageDisplay.hidden = NO;
    }
}

#pragma mark - Calculations
-(float)updateRockWidth
{
    return initialWidth + self.daysSinceFirstDate;
}

-(float)updateRockHeight
{
    return initialHeight + self.daysSinceFirstDate;
}

#pragma mark - tap gesture recognizer
- (IBAction)handleRockTouch:(UITapGestureRecognizer *)sender {
    if(self.canPetRock){
        NSLog(@"sup");
        self.canPetRock = NO;
        [self performSelector:@selector(allowRockPetting) withObject:nil afterDelay:petFrequency];
    }
}

- (void) allowRockPetting{
    if(self.age >= 5 ){
    self.canPetRock = YES;
    }
}

#pragma mark - Memory Warnings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)updateSettingsLabel {
    if(self.age >= 15){
        self.settingsLabel.hidden = NO;
    }
}

-(void)setRockAge {
    
    //We should make this so it isn't dependant on selfDaysSinceFirsDate
    self.age = (int)roundf(self.daysSinceFirstDate);
    
}

-(void)askNotificationPermission{
    
    //We won't ask for permission until the rock is 5. Is there anyway to change how we word it? We should tell the user Rock has learned to talk and thus we need notification permission
    
    if (self.age >= 5) {
    
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
