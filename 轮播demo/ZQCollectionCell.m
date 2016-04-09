//
//  ZQCollectionCell.m
//  ZQJiemian
//
//  Created by czq on 15/12/14.
//  Copyright (c) 2015年 陈樟权. All rights reserved.
//

#import "ZQCollectionCell.h"
#define detailViewH 50
@interface ZQCollectionCell()

@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UIView *detailView;
@property(nonatomic,weak)UILabel *titleView;

@end

@implementation ZQCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView =[[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        imageView.layer.cornerRadius = 8;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)]];

    }
    return self;
}



-(void)setPicUrl:(NSString *)picUrl{
    _picUrl = picUrl;
    
    self.imageView.image = [UIImage imageNamed:picUrl];

    
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;


}

-(void)imageViewClick{
    NSLog(@"imageViewClick");
    if(self.imageClick){
        self.imageClick(self.page);
    }
}

@end
