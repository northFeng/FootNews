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



- (void)setCellModel:(ListModel *)model{
    
    kImgViewSetImage(_imgIcon, model.info_pic, @"img_holder");
    
    _labelTitle.text = model.info_title;
    
    _labelType.text = model.info_type_name;
    
    _labelCount.text = [NSString stringWithFormat:@"%@阅读量",model.comment_num];
    
    NSArray *array = [model.info_time componentsSeparatedByString:@" "];
    NSString *timeStr = array.count ? array[0] : @"";
    array = timeStr.length ? [timeStr componentsSeparatedByString:@"-"] : nil;
    timeStr = [NSString stringWithFormat:@"%@-%@",array[array.count - 2],array[array.count - 1]];
    _labelTime.text = timeStr;
    
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
