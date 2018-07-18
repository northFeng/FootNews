//
//  VideoCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/18.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _imgView.layer.cornerRadius = 4;
    _imgView.layer.masksToBounds = YES;
    _imgView.clipsToBounds = YES;
    
    _blcakView.layer.cornerRadius = 4;
    _blcakView.layer.masksToBounds = YES;
    
}


- (void)setCellModel:(VideoModel *)model{
    
    kImgViewSetImage(_imgView, model.imgurl, @"img_holder");
    
    _labelTitle.text = model.title;
    
    _labelAuthor.text = model.authorName;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
