//
//  TBCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TBModel.h"

@interface TBCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *blcakView;


@property (weak, nonatomic) IBOutlet UIImageView *imgBack;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelSum;

- (void)setCellModel:(TBModel *)model;

@end
