//
//  ViewController.m
//  RockPet
//
//  Created by Michael Maloof on 11/18/14.
//  Copyright (c) 2014 Michael Maloof. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSDate *firstDate;
@property NSDate *currentDate;
@property NSDateFormatter *formatter;
@property float daysSinceFirstDate;
@property BOOL usedBefore;
@property float newHeight;
@property float newWidth;
@property (weak, nonatomic) IBOutlet UIImageView *rock;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"sup";
    
    //set date format to year, month, and day
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat: @"yyyy-MM-dd"];
    
    //load the bool for if the user has used the app or not
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    self.usedBefore = [use integerForKey:@"used"];
    NSLog(@"used before? %ld,", (long)self.usedBefore);
    self.newWidth = 40;
    self.newHeight = 40;
    
    [self adjustRockSize];
    
}

-(void)adjustRockSize
{
    //actions to do if the user has or has not used the app
    if (self.usedBefore == 0)
    {
        //turn today's date into a string and save it
        self.firstDate = [NSDate date];
        NSString *stringFromDate = [self.formatter stringFromDate:self.firstDate];
        NSUserDefaults *firstDateDefault = [NSUserDefaults standardUserDefaults];
        [firstDateDefault setObject: stringFromDate forKey:@"firstDate"];
        
        //turn self.usedBefore bool to YES
        NSUserDefaults *use= [NSUserDefaults standardUserDefaults];
        [use setBool:1 forKey:@"used"];
        
    }
    
    
    if(self.usedBefore == 1)
    {
        //load users first date on the app and convert from string to date
        NSUserDefaults *firstDateDefault = [NSUserDefaults standardUserDefaults];
        NSString *firstDateString = [firstDateDefault stringForKey:@"firstDate"];
        self.firstDate = [self.formatter dateFromString:firstDateString];
        NSLog(@"first date = %@", self.firstDate);
        
        //find time between user's first date and today
        self.currentDate = [NSDate date];
        NSLog(@"current date = %@", self.currentDate);
        self.daysSinceFirstDate = [self.currentDate timeIntervalSinceDate:self.firstDate]/86400;
        NSLog(@"days since= %f", self.daysSinceFirstDate);
        
        //adjust size of rock
        self.newHeight = self.newHeight + (self.daysSinceFirstDate);
        NSLog(@"height = %f", self.newHeight);
        self.newWidth = self.newWidth + (self.daysSinceFirstDate);
        NSLog(@"width = %f", self.newWidth);
        self.rock.frame = CGRectMake(
                                     self.rock.frame.origin.x,
                                     self.rock.frame.origin.y, self.newWidth, self.newHeight);
        NSLog(@"%@", NSStringFromCGRect(self.rock.frame));
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
