//
//  ARViewController.m
//  ARNavBar
//
//  Created by Alessio Roberto on 03/05/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
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
//

#import "ARFirstViewController.h"


@interface ARFirstViewController ()

@end

@implementation ARFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel* firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 300, 70)];
    [firstLabel setText:@"I'M THE FIRST\nVIEW CONTROLLER"];
    [firstLabel setTextAlignment:NSTextAlignmentCenter];
    [firstLabel setTextColor:[UIColor whiteColor]];
    [firstLabel setNumberOfLines:2];
    [firstLabel setFont:[UIFont fontWithName:@"ArialMT" size:30.0f]];
    [self.view addSubview:firstLabel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)closeView
{
    // Manage VC close
}

- (void)functionsManagment:(NSInteger)number
{
    // Manage functions
}

@end
