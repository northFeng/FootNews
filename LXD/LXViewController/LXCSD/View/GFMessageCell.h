//
//  GFMessageCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/13.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GFMessageModel.h"

@interface GFMessageCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *labelOne;

@property (weak, nonatomic) IBOutlet UILabel *labelTwo;

@property (weak, nonatomic) IBOutlet UILabel *labelThr;

@property (weak, nonatomic) IBOutlet UILabel *labelFor;

- (void)setCellModel:(GFMessageModel *)model;

@end
