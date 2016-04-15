//
//  MyCustomCell.m
//  shoppingCAr
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyCustomCell.h"
#define WIDTH ([UIScreen mainScreen].bounds.size.width)
@implementation MyCustomCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        布局页面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, WIDTH-10, 95)];
        
        bgView.backgroundColor = [UIColor whiteColor];
        
        //添加商品图片
        
        _goodsImgV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 80, 80)];
        
        _goodsImgV.backgroundColor = [UIColor greenColor];
        
        [bgView addSubview:_goodsImgV];
        
        //添加商品标题
        
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 200, 30)];
        
        _goodsTitleLab.text = @"afadsfa fa";
        
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        
        [bgView addSubview:_goodsTitleLab];
        
        //促销价
        
        _priceTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 35, 70, 30)];
        
        _priceTitleLab.text = @"促销价:";
        
        _priceTitleLab.backgroundColor = [UIColor clearColor];
        
        [bgView addSubview:_priceTitleLab];
        
        //商品价格
        
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(160, 35, 100, 30)];
        
        _priceLab.text = @"1990";
        
        _priceLab.textColor = [UIColor redColor];
        
        [bgView addSubview:_priceLab];
        
        //购买数量
        
        _goodsNumLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 65, 90, 30)];
        
        _goodsNumLab.text = @"购买数量：";
        
        [bgView addSubview:_goodsNumLab];
        
        //减按钮
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _deleteBtn.frame = CGRectMake(180, 65, 30, 30);
        
        [_deleteBtn setImage:[UIImage imageNamed:@"按钮-.png"] forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = [UIColor redColor];
        
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteBtn.tag = 11;
        
        [bgView addSubview:_deleteBtn];
        
        //购买商品的数量
        
        _numCountLab = [[UILabel alloc]initWithFrame:CGRectMake(210, 65, 50, 30)];
        
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        
        [bgView addSubview:_numCountLab];
        
        //加按钮
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _addBtn.frame = CGRectMake(260, 65, 30, 30);
        
        [_addBtn setImage:[UIImage imageNamed:@"按钮+.png"] forState:UIControlStateNormal];
        _addBtn.backgroundColor = [UIColor grayColor];
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _addBtn.tag = 12;
        
        [bgView addSubview:_addBtn];
        
        //是否选中图片
        
        _isSelectImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 50, 10, 30, 30)];
        [bgView addSubview:_isSelectImg];
        
        [self addSubview:bgView];
        

    }
    
    return  self;
    
    
}
-(void)addTheValue:(GoodInfoModel *)goodsmodel{
    
    _goodsImgV.image = [UIImage imageNamed:goodsmodel.imageName];
    
    _goodsTitleLab.text = goodsmodel.goodsTitle;
    
    _priceLab.text = goodsmodel.goodsPrice;
    
    _numCountLab.text = [NSString stringWithFormat:@"%d",goodsmodel.goodsNum];
    
    if (goodsmodel.selectState)
        
    {
        
        _selectState = YES;
        
        _isSelectImg.image = [UIImage imageNamed:@"复选框-选中"];
        
    }else{
        
        _selectState = NO;
        
        _isSelectImg.image = [UIImage imageNamed:@"复选框-未选中"];
        
    }
    
}
-(void)deleteBtnAction:(UIButton*)sender{
    
//    判断是否选中才能点击
    if (_selectState == YES) {
//        调用代理
        [self.delegate Click:self andFlag:(int)sender.tag];
        
    }
    
    
}
//点击按钮实现数量的增加
-(void)addBtnAction:(UIButton*)sender{
//    判断是否选中选中才能点击
    if (_selectState == YES) {
//        调用代理
        [self.delegate Click:self andFlag:(int)sender.tag];
    }
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
