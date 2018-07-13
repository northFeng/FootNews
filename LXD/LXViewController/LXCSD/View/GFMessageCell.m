//
//  GFMessageCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/13.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "GFMessageCell.h"

@implementation GFMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(GFMessageModel *)model{
    
    _labelOne.text = model.info_title;
    
    NSString *desString;
    if ([model.info_desc hasPrefix:@"<span>"]) {
        desString = [model.info_desc substringWithRange:NSMakeRange(@"<span>".length, model.info_desc.length - @"<span>".length - @"</span>".length)];
    }
    _labelTwo.text = desString;
    
    _labelThr.text = [NSString stringWithFormat:@"%@",model.info_src];//model.comment_num
    
    
    NSArray *array = [model.info_time componentsSeparatedByString:@" "];
    NSString *timeStr = array.count ? array[0] : @"";
    _labelFor.text = timeStr;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
