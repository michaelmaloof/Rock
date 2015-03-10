//
//  Rock.h
//  RockPet
//
//  Created by Michael Maloof on 3/8/15.
//  Copyright (c) 2015 Michael Maloof. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Rock : UIImageView

@property NSDate *firstDate;
@property NSDateFormatter *formatter;
@property float daysSinceFirstDate;
@property (nonatomic) BOOL canPetRock;
@property int age;
@property bool hasSentA;
@property bool hasSentB;
@property bool hasSentCDEF;
@property bool hasSentGHIJ;
@property bool hasSentZ;
@property bool hasRockLearnedToTalk;


-(void)loadFirstDateDefault;
-(void)setFirstDateDefault;
-(void)setRockAge;
-(void)allowRockPetting;

-(void)createLetterANotification;
-(void)createLetterBNotification;
-(void)createLetterCDEFNotification;
-(void)createLetterGHIJNotification;
-(void)createLetterZNotification;
    



@end

