//
//  MyCell.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/19.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;



- (void)setCellString:(NSString *)string;


@end
