//
//  TodayHomeCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TodayModel.h"

@interface TodayHomeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelType;

@property (weak, nonatomic) IBOutlet UILabel *labelCount;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;


- (void)setCellModel:(ListModel *)model;


@end
