//
//  ZLCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "ZLCell.h"

@implementation ZLCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(ZLModel *)model{
    
    kImgViewSetImage(_imgIcon, model.icon, @"img_holder");
    _labelTTitle.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
