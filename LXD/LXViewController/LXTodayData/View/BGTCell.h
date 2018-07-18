//
//  BGTCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TodayModel.h"

@interface BGTCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelAuthoe;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property (weak, nonatomic) IBOutlet UIImageView *imgOne;

@property (weak, nonatomic) IBOutlet UIImageView *imgTwo;

@property (weak, nonatomic) IBOutlet UIImageView *imgThr;



- (void)setCellModel:(TodayModel *)model;


@end
