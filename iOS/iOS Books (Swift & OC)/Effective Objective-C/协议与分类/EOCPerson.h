//
//  EOCPerson.h
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCPerson : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSArray *friends;

-(instancetype)initWithFirstName: (NSString*)firstName andLastName: (NSString*)lastName;

@end


@interface EOCPerson (Play)

- (void)goToTheCinema;

@end


@interface EOCPerson (FriendsShip)

- (void)addFriend: (EOCPerson*)person;

@end


@interface EOCPerson (Work)

- (void)performDaysWork;

@end
