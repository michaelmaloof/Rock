//
//  ViewController.m
//  RockPet
//
//  Created by Michael Maloof on 11/18/14.
//  Copyright (c) 2014 Michael Maloof. All rights reserved.
//

#import "ViewController.h"


static float const initialWidth = 40;
static float const initialHeight = 40;

@interface ViewController ()

@property NSDate *firstDate;
@property NSDateFormatter *formatter;
@property float daysSinceFirstDate;
@property (weak, nonatomic) IBOutlet UIImageView *rock;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rockHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rockWidth;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Use NSLocalizedString to handle multiple languages
    self.title = NSLocalizedString(@"sup","sup");
    
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

#pragma mark - Calculations
-(float)updateRockWidth
{
    return initialWidth + self.daysSinceFirstDate;
}

-(float)updateRockHeight
{
    return initialHeight + self.daysSinceFirstDate;
}

#pragma mark - Memory Warnings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
