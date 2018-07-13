//
//  TodayHomeCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "TodayHomeCell.h"

@implementation TodayHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setCellModel:(TodayModel *)model{
    
    kImgViewSetImage(_imgIcon, model.imglink, @"img_holder");
    
    _labelTitle.text = model.title;
    
    _labelType.text = model.content168;
    
    _labelTime.text = model.author;
    
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
