//
//  TBCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "TBCell.h"

@implementation TBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _imgBack.layer.cornerRadius = 4;
    _imgBack.layer.masksToBounds = YES;
    _imgBack.clipsToBounds = YES;
    
    _blcakView.layer.cornerRadius = 4;
    _blcakView.layer.masksToBounds = YES;
}


- (void)setCellModel:(TBModel *)model{
    
    kImgViewSetImage(_imgBack, model.img, @"img_holder");
    
    _labelTitle.text = model.title;
    
    _labelSum.text = model.descriptionS;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
