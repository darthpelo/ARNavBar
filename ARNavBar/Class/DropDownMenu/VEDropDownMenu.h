//
//  VEDropDownMenu.h
//  VeespoFramework
//
//  Created by Alessio Roberto on 26/04/13.
//  Copyright (c) 2013 Veespo Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VEDropDownMenu : UIView <UITableViewDelegate, UITableViewDataSource> {
    BOOL goDownDirection;
}

@property (nonatomic, copy) void (^function)(NSInteger index);
@property (nonatomic, copy) void (^releseMenu)();

- (void)hideDropDown:(UIView *)view;
- (id)showDropDown:(UIView *)view titleList:(NSArray *)titleList imageList:(NSArray *)imageList directionDown:(BOOL)direction;

@end
