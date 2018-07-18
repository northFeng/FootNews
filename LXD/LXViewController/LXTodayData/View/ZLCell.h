//
//  ZLCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZLModel.h"

@interface ZLCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

@property (weak, nonatomic) IBOutlet UILabel *labelTTitle;


- (void)setCellModel:(ZLModel *)model;


@end
