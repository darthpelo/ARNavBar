//
//  NPNavBar.h
//  ARNavBar
//
//  Created by Niccolò Passolunghi on 29/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSUInteger, NPNavBarConfiguration) {
//    NPNavBarDefault,
//    NPNavBarOnlyCloseBtn
//};

@interface VENavBar : UINavigationBar

@property (nonatomic, copy) void (^menuPressed)(BOOL isOpen, VENavBar* navBar);
@property (nonatomic, copy) void (^closePressed)();
@property (nonatomic, copy) void (^functionRequest)(NSInteger number);
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIButton* rightButton;
@property (nonatomic, strong) UIButton* menuButton;

- (void)closeMenu;

@end
