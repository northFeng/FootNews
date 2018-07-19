//
//  MyCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/19.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellString:(NSString *)string{
    
    _labelTitle.text = string;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
