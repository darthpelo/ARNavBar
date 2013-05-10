//
//  VENavBar.h
//  VeespoFramework
//
//  Created by Alessio Roberto on 31/01/13.
//  Copyright (c) 2013 Veespo Ltd. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "VEDropDownMenu.h"

#define NAVBAR_VIEW_WIDTH   44

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
@property (nonatomic, copy) void (^functionRequest)(NSInteger number);
@property (nonatomic, strong) NSString *title;

+ (NSInteger)height;
- (id)initWithFrame:(CGRect)frame configuration:(VENavBarConfiguration)config;
- (void)changeButtonImage;
- (void)closeMenu;

@end
