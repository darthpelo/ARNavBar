//
//  VENavBar.m
//  VeespoFramework
//
//  Created by Alessio Roberto on 31/01/13.
//  Copyright (c) 2013 Veespo Ltd. All rights reserved.
//

#import "VENavBar.h"
#import "VEGlobalUICommon.h"
#import "VENoRateableTagsViewController.h"

@implementation VENavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame configuration:(VENavBarConfiguration)config andSkin:(NSInteger)skin
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bb = [[UIImageView alloc] initWithFrame:frame];
        bb.image = [VEVeespoImage image:@"navbar.png"];
        if (skin == v6)
            bb.image = [VEVeespoImage imageQurami:@"navbar.png"];
        [self addSubview:bb];
        
        switch (config) {
            case VENavBarDefault:{
                closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(276, 0, 44, 44)];
                [closeBtn setImage:[VEVeespoImage image:@"button-close-app.png"] forState:UIControlStateNormal];
                [closeBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:closeBtn];
                
                menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
                [menuBtn setImage:[VEVeespoImage image:@"Veespo-menu.png"] forState:UIControlStateNormal];
                [menuBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:menuBtn];
            }
                break;
            case VENavBarOnlyCloseBtn:{
                closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(276, 0, 44, 44)];
                [closeBtn setImage:[VEVeespoImage image:@"button-close-app.png"] forState:UIControlStateNormal];
                [closeBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:closeBtn];
            }
                break;
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, 232, 44)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:24];
    [self addSubview:titleLabel];
}

- (IBAction)buttonPressed:(id)sender
{
    if (sender == closeBtn) {
        if (self.closePressed)
            self.closePressed();
    } else if (sender == menuBtn) {
        if(dropDown == nil) {
            self.menuPressed(YES, self);
            NSArray *arr = [NSArray arrayWithObjects:@"Aggiungi un commento", @"Informazioni sul tag selezionato", @"Help", @"Cambia lingua", @"Credits", nil];
            NSArray *arrImage = [NSArray arrayWithObjects:[VEVeespoImage image:@"button-comment.png"], [VEVeespoImage image:@"button-info.png"], [VEVeespoImage image:@"button-help.png"], [VEVeespoImage image:@"button-help.png"], nil];
            dropDown = [[VEDropDownMenu alloc] showDropDown:self titleList:arr imageList:arrImage directionDown:YES];
            __weak id bSelf = self;
            dropDown.function = ^(NSInteger index){
                [bSelf closeMenu];
                [bSelf sendRequest:index];
            };
            dropDown.releseMenu = ^{
                [bSelf closeMenu];
            };
        } else {
            [self closeMenu];
            self.menuPressed(NO, self);
        }
    }
}

- (void)closeMenu
{
    [dropDown hideDropDown:self];
    dropDown = nil;
}

- (void)sendRequest:(NSInteger)number
{
    if (self.functionRequest) {
        self.functionRequest(number);
    }
    [UIView animateWithDuration:0.5 animations:^{self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 44);}];
}

- (void)changeButtonImage
{
    [closeBtn setImage:[VEVeespoImage image:@"button-OK.png"] forState:UIControlStateNormal];
}
@end
