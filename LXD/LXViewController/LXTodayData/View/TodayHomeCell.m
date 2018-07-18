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
    
    kImgViewSetImage(_imgIcon, model.imgurl, @"img_holder");
    
    _labelTitle.text = model.title;
    
    _labelType.text = [NSString stringWithFormat:@"小编:%@",model.authorName];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[model.newstime doubleValue]/1000.0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *timeString = [dateformatter stringFromDate:date];
    _labelTime.text = timeString;
    
}


- (void)setCellModelTwo:(ScoreModel *)model{
    
    kImgViewSetImage(_imgIcon, model.file, @"img_holder");
    
    _labelTitle.text = model.title;
    
    _labelType.text = model.team;
    
//    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[model.newstime doubleValue]/1000.0];
//    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *timeString = [dateformatter stringFromDate:date];
    _labelTime.text = model.input_time;
    
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
