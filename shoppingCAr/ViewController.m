//
//  ViewController.m
//  shoppingCAr
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "GoodInfoModel.h"
#import "MyCustomCell.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MyCustomCellDelegate>
{
    UITableView * _MytableView;
    float allPrice;
    NSMutableArray * infoArr;
}
@property(nonatomic,retain)UIButton * allSelectBtn;
@property(nonatomic,retain)UILabel * allPriceLab;
@end

@implementation ViewController
-(void)initData{
    infoArr = [[NSMutableArray alloc]init];
    allPrice = 0.0;
    for (int i = 0 ; i<7; i++) {
        NSMutableDictionary * infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:@"img6.png" forKey:@"imageName"];
        
        [infoDict setValue:@"这是商品标题" forKey:@"goodsTitle"];
        
        [infoDict setValue:@"2000" forKey:@"goodsPrice"];
        
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        
        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodsNum"];
        
        GoodInfoModel * GoodModel = [[GoodInfoModel alloc]initWithDict:infoDict];
        [infoArr addObject:GoodModel];
    }
    
}
-(UIView*)createFootView{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-150, 10, 50, 30)];
    label.text = @"allSelected";
    [footView addSubview:label];
    //添加全选图片按钮
    
    _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _allSelectBtn.frame = CGRectMake(self.view.frame.size.width- 100, 10, 30, 30);
    
    [_allSelectBtn setImage:[UIImage imageNamed:@"复选框-未选中"] forState:UIControlStateNormal];
    
    [_allSelectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:_allSelectBtn];
    
    //添加小结文本框
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 150, 40, 60, 30)];
    
    lab2.textColor = [UIColor redColor];
    
    lab2.text = @"小结：";
    
    [footView addSubview:lab2];
    
    //添加一个总价格文本框，用于显示总价
    
    _allPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, 40, 100, 30)];
    
    _allPriceLab.textColor = [UIColor redColor];
    
    _allPriceLab.text = @"0.0";
    
    [footView addSubview:_allPriceLab];
    
    //添加一个结算按钮
    
    UIButton *settlementBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [settlementBtn setTitle:@"去结算" forState:UIControlStateNormal];
    
    [settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    settlementBtn.frame = CGRectMake(10, 80, self.view.frame.size.width - 20, 30);
    
    settlementBtn.backgroundColor = [UIColor blueColor];
    
    [footView addSubview:settlementBtn];
    
    return footView;
}
-(void)CrateTableView{
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)style:UITableViewStylePlain];
    _MytableView.dataSource = self;
    _MytableView.delegate = self;
//    给表哥添加一个尾部视图
    _MytableView.tableFooterView = [self createFootView];
    
    [self.view addSubview:_MytableView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self CrateTableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma tableviewDelegateMethod
//实现单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return infoArr.count;
}

//定制单元格内容
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"identify";
    MyCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
    cell = [[MyCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.delegate = self;
    }
    
//    调用方法给单元格赋值
    [cell addTheValue:infoArr[indexPath.row]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    判断当前是否为选中状态，如果为选中状态则更改更改成未选中，如果未选中改成选中
    GoodInfoModel * model = infoArr[indexPath.row];
    if (model.selectState) {
        model.selectState = NO;
    }else{
        
        model.selectState  = YES;
    }
    
    [_MytableView reloadData];
//    刷新当前行
    [_MytableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self totalPrice];
  
}
//全选方法的实现
-(void)selectBtnClick:(UIButton*)sender{
//    判断是否选中，是改成否，否改成是，改变图片状态
    sender.tag = !sender.tag;
    if (sender.tag) {
        [sender setImage:@"111.png" forState:UIControlStateNormal];
    }else{
        [sender setImage:@"222.png" forState:UIControlStateNormal];
    }
//    改变单元格选中状态
    for (int i = 0 ; i<infoArr.count; i++) {
        GoodInfoModel * model = [infoArr objectAtIndex:i];;
        model.selectState = sender.tag;
        
    }
//    计算价格
    [self totalPrice];
//    刷新表格
    [_MytableView reloadData];
    
    
    
}
-(void)Click:(UITableViewCell*)cell andFlag:(int)flag
{
    
    NSIndexPath * index = [_MytableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
//           做减法
//           先获取到当前数组源内容，改变数组源内容，刷新表哥
            GoodInfoModel * model = infoArr[index.row];
            if (model.goodsNum>1) {
                model.goodsNum --;
            }
            
        }
            break;
            case 12:
        {
//            做加法
            GoodInfoModel * model = infoArr[index.row];
            model.goodsNum++;
            
            
        }
        default:
            break;
    }
}

//计算总价格
-(void)totalPrice{
//   遍历整个数组源判断如果是选中的商品，就计算价格
    for (int i = 0; i < infoArr.count; i++) {
        GoodInfoModel * model = [infoArr objectAtIndex:i];;
        if (model.selectState) {
            allPrice = allPrice + model.goodsNum*[model.goodsPrice intValue];
        }
    }
    
//   给总价文本赋值
    _allPriceLab.text = [NSString stringWithFormat:@"%.2f",allPrice];
//   每次算完要重置为零，因为每次都是全部循环算一遍
    allPrice = 0.0;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
