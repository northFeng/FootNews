//
//  GFPersonCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/10.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "GFPersonCell.h"

@implementation GFPersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setCellModel:(GFPersonModel *)model{
    
    _labelOne.text = [NSString stringWithFormat:@"NO.%@",model.serial];
    
    _labelTwo.text = [NSString stringWithFormat:@"魅力值：%@",model.value];
    
    _labelThr.text = model.playerName;
    
    kImgViewSetImage(_imgIcon, model.playerIcon, @"img_holder");
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
