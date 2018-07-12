//
//  GFScoreCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "GFScoreCell.h"

@implementation GFScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setCellModel:(ScoreModel *)model{
    
    NSArray *array = [model.match_time componentsSeparatedByString:@" "];
    
    _labelTime.text = array.count >= 2 ? array[1] : @"";

    _labelTitle.text = model.league_name;
    
    //NSString *textColor = [model.league_color substringFromIndex:1];
    _labelTitle.textColor = RGB(255,165,0);//[UIColor redColor];
    
    _labelBF.text = [NSString stringWithFormat:@"%@-%@",model.home_team_score,model.guest_team_score];
    
    
    //左边
    _labelLeftName.text = model.home_team_name;
    
    if (model.home_team_rank.length == 0) {
        _labelLeftCount.text = @"";
    }else{
        _labelLeftCount.text = [NSString stringWithFormat:@"[%@]",model.home_team_rank];
    }
    
    _labelLeftScore.text = [NSString stringWithFormat:@" %@ ",model.h_yellow];
    if (model.h_yellow.length == 0) {
        _labelLeftScore.hidden = YES;
    }else{
        _labelLeftScore.hidden = NO;
    }

    //右边
    _labelRightName.text = model.guest_team_name;
    
    if (model.guest_team_rank.length == 0) {
        _labelRightCount.text = @"";
    }else{
        _labelRightCount.text = [NSString stringWithFormat:@"[%@]",model.guest_team_rank];
    }
    
    if (model.g_yellow.length == 0) {
        _labelRightScore.hidden = YES;
    }else{
        _labelRightScore.hidden = NO;
        _labelRightScore.text = [NSString stringWithFormat:@" %@ ",model.g_yellow];
    }
    
    //底部
    _labelLeft.text = model.asian_odds.length ? model.asian_odds : @"-";
    
    _labelRight.text = model.europe_odds.length ? model.europe_odds : @"-";
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
