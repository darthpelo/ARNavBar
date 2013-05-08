//
//  VENavBar.m
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

#import "VENavBar.h"

@implementation VENavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame configuration:(VENavBarConfiguration)config
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bb = [[UIImageView alloc] initWithFrame:frame];
        bb.image = [UIImage imageNamed:@"navbar.png"];
        [self addSubview:bb];
        
        switch (config) {
            case VENavBarDefault:{
                closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(276, 0, 44, 44)];
                [closeBtn setImage:[UIImage imageNamed:@"button-close-app.png"] forState:UIControlStateNormal];
                [closeBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:closeBtn];
                
                menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
                [menuBtn setImage:[UIImage imageNamed:@"button-menu.png"] forState:UIControlStateNormal];
                [menuBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:menuBtn];
            }
                break;
            case VENavBarOnlyCloseBtn:{
                closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(276, 0, 44, 44)];
                [closeBtn setImage:[UIImage imageNamed:@"button-close-app.png"] forState:UIControlStateNormal];
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
    titleLabel.textAlignment = NSTextAlignmentCenter;
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
            NSArray *arr = [NSArray arrayWithObjects:@"Add tag's comment", @"Tag info", @"Help", @"Languages", nil];
            NSArray *arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"icona_commenti.png"],
                                 [UIImage imageNamed:@"icona_info.png"],
                                 [UIImage imageNamed:@"icona_help.png"],
                                 [UIImage imageNamed:@"cambio-lingua.png"], nil];
            dropDown = [[VEDropDownMenu alloc] showDropDown:self
                                                  titleList:arr
                                                  imageList:arrImage
                                              directionDown:YES];
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
    [closeBtn setImage:[UIImage imageNamed:@"button-OK.png"] forState:UIControlStateNormal];
}
@end
