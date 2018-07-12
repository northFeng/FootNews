//
//  GFScoreCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScoreModel.h"

@interface GFScoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property (weak, nonatomic) IBOutlet UILabel *labelBF;


//左边
@property (weak, nonatomic) IBOutlet UILabel *labelLeftName;

@property (weak, nonatomic) IBOutlet UILabel *labelLeftCount;

@property (weak, nonatomic) IBOutlet UILabel *labelLeftScore;


//右边
@property (weak, nonatomic) IBOutlet UILabel *labelRightName;

@property (weak, nonatomic) IBOutlet UILabel *labelRightCount;

@property (weak, nonatomic) IBOutlet UILabel *labelRightScore;


//底部
@property (weak, nonatomic) IBOutlet UILabel *labelLeft;

@property (weak, nonatomic) IBOutlet UILabel *labelRight;



- (void)setCellModel:(ScoreModel *)model;






@end
