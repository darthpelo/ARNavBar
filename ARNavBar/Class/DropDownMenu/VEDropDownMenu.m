//
//  VEDropDownMenu.m
//  VeespoFramework
//
//  Created by Alessio Roberto on 26/04/13.
//  Copyright (c) 2013 Veespo Ltd. All rights reserved.
//

#import "VEDropDownMenu.h"
#import "QuartzCore/QuartzCore.h"

#define CELL 44
#define FOTHER_HEIGHT 33

@interface VEDropDownMenu ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIView *viewSender;
@property(nonatomic, retain) NSArray *list;
@property(nonatomic, retain) NSArray *imgList;
@end

@implementation VEDropDownMenu
@synthesize table;
@synthesize viewSender;
@synthesize list;
@synthesize imgList;

- (id)showDropDown:(UIView *)view titleList:(NSArray *)titleList imageList:(NSArray *)imageList directionDown:(BOOL)direction
{
    viewSender = view;
    goDownDirection = direction;
    
    self.table = (UITableView *)[super init];
    if (self) {
        self.list = [NSArray arrayWithArray:titleList];
        self.imgList = [NSArray arrayWithArray:imageList];
        if (!goDownDirection) {
            self.frame = CGRectMake(viewSender.frame.origin.x, viewSender.frame.origin.y, 320, 0);
            self.layer.shadowOffset = CGSizeMake(0, -3);
        }else {
            self.frame = CGRectMake(viewSender.frame.origin.x, viewSender.frame.origin.y+viewSender.frame.size.height, 320, 0);
            self.layer.shadowOffset = CGSizeMake(0, 3);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = [UIColor clearColor];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [table setScrollEnabled:NO];
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, table.frame.size.width, FOTHER_HEIGHT)];
        [footerView setBackgroundColor:[UIColor clearColor]];
        UIImageView *logo = [[UIImageView alloc] initWithFrame:footerView.frame];
        logo.image = [VEVeespoImage image:@"footer_menu.png"];
        [logo setBackgroundColor:[UIColor clearColor]];
        [footerView addSubview:logo];
        table.tableFooterView = footerView;
        
        [UIView animateWithDuration:0.4 animations:^{
            if (!goDownDirection)
                self.frame = CGRectMake(viewSender.frame.origin.x, viewSender.frame.origin.y - (self.list.count * CELL), 320, self.list.count * CELL);
            else
                self.frame = CGRectMake(viewSender.frame.origin.x, viewSender.frame.origin.y + viewSender.frame.size.height, 320, (self.list.count * CELL) + FOTHER_HEIGHT);
            
            table.frame = CGRectMake(0, 0, 320, (self.list.count * CELL) + FOTHER_HEIGHT);
        }];
        
        [view.superview addSubview:self];
        [self addSubview:table];
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
        table.frame = CGRectMake(0, 0, 320, 0);
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
    UIImage *rowBackground = [VEVeespoImage image:@"sfondo_cella_menu.png"];
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
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    if ([self.imgList count] == [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        cell.imageView.image = [imgList objectAtIndex:indexPath.row];
    } else if ([self.imgList count] > [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        if (indexPath.row < [imgList count]) {
//            cell.imageView.image = [imgList objectAtIndex:indexPath.row];
//        }
    } else if ([self.imgList count] < [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        if (indexPath.row < [imgList count]) {
//            cell.imageView.image = [imgList objectAtIndex:indexPath.row];
//        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:viewSender];
    self.releseMenu();
    self.function(indexPath.row);

}
@end
