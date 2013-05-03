//
//  VENavBar.h
//  VeespoFramework
//
//  Created by Alessio Roberto on 31/01/13.
//  Copyright (c) 2013 Veespo Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "VEDropDownMenu.h"

typedef enum {
    VENavBarDefault,
    VENavBarOnlyCloseBtn
} VENavBarConfiguration;

@interface VENavBar : UIView {
    UIButton *menuBtn;
    UIButton *closeBtn;
    UILabel *titleLabel;
    VEDropDownMenu *dropDown;
    UIView *bkgr;
}

@property (nonatomic, copy) void (^menuPressed)(BOOL isOpen, VENavBar *navBar);
@property (nonatomic, copy) void (^closePressed)();
@property (nonatomic, strong) void (^functionRequest)(NSInteger number);
@property (nonatomic, strong) NSString *title;

- (id)initWithFrame:(CGRect)frame configuration:(VENavBarConfiguration)config andSkin:(NSInteger)skin;
- (void)changeButtonImage;
- (void)closeMenu;

@end
