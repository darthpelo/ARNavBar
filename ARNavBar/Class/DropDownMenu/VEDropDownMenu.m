//
//  VEDropDownMenu.m
//  VeespoFramework
//
//  Created by Alessio Roberto on 26/04/13.
//  Copyright 2012 Nitor Infotech
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//                                                            "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "VEDropDownMenu.h"
#import "QuartzCore/QuartzCore.h"

#define CELL 44

@interface VEDropDownMenu ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIView *viewSender;
@property(nonatomic, retain) NSArray *list;
@property(nonatomic, retain) NSArray *imgList;
@end

@implementation VEDropDownMenu

- (id)showDropDown:(UIView *)view titleList:(NSArray *)titleList imageList:(NSArray *)imageList directionDown:(BOOL)direction
{
    self.viewSender = view;
    goDownDirection = direction;
    
    self.table = (UITableView *)[super init];
    if (self) {
        self.list = [NSArray arrayWithArray:titleList];
        self.imgList = [NSArray arrayWithArray:imageList];
        if (!goDownDirection) {
            self.frame = CGRectMake(self.viewSender.frame.origin.x, self.viewSender.frame.origin.y, 320, 0);
            self.layer.shadowOffset = CGSizeMake(0, -3);
        }else {
            self.frame = CGRectMake(self.viewSender.frame.origin.x, self.viewSender.frame.origin.y+self.viewSender.frame.size.height, 320, 0);
            self.layer.shadowOffset = CGSizeMake(0, 3);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.5;
        
        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.table setScrollEnabled:NO];
        
        [UIView animateWithDuration:0.4 animations:^{
            if (!goDownDirection)
                self.frame = CGRectMake(self.viewSender.frame.origin.x, self.viewSender.frame.origin.y - (self.list.count * CELL), 320, self.list.count * CELL);
            else
                self.frame = CGRectMake(self.viewSender.frame.origin.x, self.viewSender.frame.origin.y + self.viewSender.frame.size.height, 320, (self.list.count * CELL));
            
            self.table.frame = CGRectMake(0, 0, 320, (self.list.count * CELL));
        }];
        
        [view.superview addSubview:self];
        [self addSubview:self.table];
    }
    return self;
}

- (void)hideDropDown:(UIView *)view
{
    [UIView animateWithDuration:0.5 animations:^{
        if (!goDownDirection)
            self.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 320, 0);
        else
            self.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + view.frame.size.height, 320, 0);
        self.table.frame = CGRectMake(0, 0, 320, 0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.backgroundView = [[UIImageView alloc] init];
    UIImage *rowBackground = [UIImage imageNamed:@"sfondo_cella_menu.png"];
    ((UIImageView *)cell.backgroundView).image = rowBackground;
    
    UIView *sv = [[UIView alloc] init];
    sv.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = sv;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self getCellContentView:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    if ([self.imgList count] == [self.list count]) {
        cell.textLabel.text =[self.list objectAtIndex:indexPath.row];
        cell.imageView.image = [self.imgList objectAtIndex:indexPath.row];
    } else if ([self.imgList count] > [self.list count]) {
        cell.textLabel.text =[self.list objectAtIndex:indexPath.row];
        if (indexPath.row < [self.imgList count]) {
            cell.imageView.image = [self.imgList objectAtIndex:indexPath.row];
        }
    } else if ([self.imgList count] < [self.list count]) {
        cell.textLabel.text =[self.list objectAtIndex:indexPath.row];
        if (indexPath.row < [self.imgList count]) {
            cell.imageView.image = [self.imgList objectAtIndex:indexPath.row];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:self.viewSender];
    self.releseMenu();
    self.function(indexPath.row);

}
@end
