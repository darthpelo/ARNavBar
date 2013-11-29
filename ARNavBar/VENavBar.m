//
//  NPNavBar.m
//  ARNavBar
//
//  Created by Niccolò Passolunghi on 29/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "VENavBar.h"
#import "VEDropDownMenu.h"

#define BAR_BUTTON_ITEM_WIDTH 44

@interface VENavBar()
@property (nonatomic, strong) VEDropDownMenu* dropDownMenu;

@end

@implementation VENavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBarTintColor:[UIColor redColor]];
        [self setTintColor:[UIColor whiteColor]];
        [self setTranslucent:NO];
        
        _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BAR_BUTTON_ITEM_WIDTH, BAR_BUTTON_ITEM_WIDTH)];
        [_menuButton setImage:[UIImage imageNamed:@"button-menu"] forState:UIControlStateNormal];
        [_menuButton addTarget:self action:@selector(menuNavPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_menuButton];

        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(235, 0, 100, BAR_BUTTON_ITEM_WIDTH)];
        [_rightButton setTitle:@"Modal" forState:UIControlStateNormal];
        [self addSubview:_rightButton];
    }
    return self;
}

- (void)menuNavPressed
{
    if(self.dropDownMenu == nil) {
        NSArray *arr = [NSArray arrayWithObjects:@"First View Controller", @"Second View Controller", @"Lore Ipsum", @"Lorem Ipsum", nil];
        NSArray *arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"icona_commenti.png"],
                             [UIImage imageNamed:@"icona_info.png"],
                             [UIImage imageNamed:@"icona_help.png"],
                             [UIImage imageNamed:@"cambio-lingua.png"], nil];
        self.dropDownMenu = [[VEDropDownMenu alloc] showDropDown:self
                                              titleList:arr
                                              imageList:arrImage
                                          directionDown:YES];
        __weak id bSelf = self;
        self.dropDownMenu.function = ^(NSInteger index){
            [bSelf closeMenu];
            [bSelf sendRequest:index];
        };
        self.dropDownMenu.releseMenu = ^{
            [bSelf closeMenu];
        };

    } else {
        [self closeMenu];
    }

}

- (void)closeMenu
{
    [self.dropDownMenu hideDropDown:self];
    self.dropDownMenu = nil;
}

- (void)sendRequest:(NSInteger)number
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), BAR_BUTTON_ITEM_WIDTH);
        
    } completion:^(BOOL finished) {
        if (self.functionRequest) {
            self.functionRequest(number);
        }
    }];
}


@end
