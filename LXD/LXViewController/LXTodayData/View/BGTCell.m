//
//  BGTCell.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "BGTCell.h"

@implementation BGTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _imgOne.layer.cornerRadius = 4;
    _imgOne.layer.masksToBounds = YES;
    
    _imgTwo.layer.cornerRadius = 4;
    _imgTwo.layer.masksToBounds = YES;
    
    _imgThr.layer.cornerRadius = 4;
    _imgThr.layer.masksToBounds = YES;
    
}

- (void)setCellModel:(TodayModel *)model{
    
    _imgOne.hidden = YES;
    _imgTwo.hidden = YES;
    _imgThr.hidden = YES;
    
    _labelTitle.text = model.title;
    _labelAuthoe.text = model.authorName;
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[model.newstime doubleValue]/1000.0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *timeString = [dateformatter stringFromDate:date];
    NSArray *array = [timeString componentsSeparatedByString:@" "];
    if (array.count) {
        timeString = array[0];
        timeString = [timeString substringFromIndex:5];
    }
    _labelTime.text = timeString;
    
    
    NSInteger index = 0;
    for (NSDictionary *dic in model.imgList) {
        /**
        "imageId":17082,
        "picimgurl":"http://resource.ttplus.cn/publish/app/pics/2018/07/16/166615/ee470024-abb5-4116-995d-0b5fbc9c0e2b.jpg@!img01",
        "picthumbnailimgurl":"http://resource.ttplus.cn/publish/app/pics/2018/07/16/166615/thumbnail/ee470024-abb5-4116-995d-0b5fbc9c0e2b.jpg@!img02",
        "width":604,
        "description":"克罗地亚96年小将查来塔-察尔妻子阿德里亚娜。",
        "height":755
         */
        if (dic[@"picthumbnailimgurl"]) {
            switch (index) {
                case 0:
                    _imgOne.hidden = NO;
                    kImgViewSetImage(_imgOne, dic[@"picthumbnailimgurl"], @"img_holder");
                    break;
                case 1:
                    _imgTwo.hidden = NO;
                    kImgViewSetImage(_imgTwo, dic[@"picthumbnailimgurl"], @"img_holder");
                    break;
                case 2:
                    _imgThr.hidden = NO;
                    kImgViewSetImage(_imgThr, dic[@"picthumbnailimgurl"], @"img_holder");
                    break;
                default:
                    break;
            }
        }
        index ++;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
