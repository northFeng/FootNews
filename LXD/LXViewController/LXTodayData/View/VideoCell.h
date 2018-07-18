//
//  VideoCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/18.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoModel.h"

@interface VideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *blcakView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelAuthor;



- (void)setCellModel:(VideoModel *)model;

@end
