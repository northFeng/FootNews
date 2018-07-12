//
//  GFPersonCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/10.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GFPersonModel.h"

@interface GFPersonCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *labelOne;

@property (weak, nonatomic) IBOutlet UILabel *labelTwo;

@property (weak, nonatomic) IBOutlet UILabel *labelThr;

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;




- (void)setCellModel:(GFPersonModel *)model;


@end
