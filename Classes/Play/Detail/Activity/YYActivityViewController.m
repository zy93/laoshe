//
//  YYActivityViewController.m
//  TableviewTest
//
//  Created by 张雨 on 2017/2/19.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "YYActivityViewController.h"
#import "YYNavView.h"
#import "YYActivityCell.h"
#import "YYActivityData.h"
#import "YYRichTextDetailController.h"

#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define NavHight 100
#define titleBottom 50

#define color_1 0x7bb6d3
#define color_2 0xda9ca7
#define color_3 0x98a6ce
#define color_4 0x88b9b0
#define color_5 0xe6daa2

@interface YYActivityViewController () <YYNavViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *_headerImg;
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    NSArray *_ColorArray;
}

@property(nonatomic,strong)UIImageView *backgroundImgV;
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,strong)YYNavView *NavView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation YYActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self backImageView];
    
    [self createNaView];
    
//    [self loadData];
    
    [self layoutTableView];
    
    _ColorArray = @[@(color_1),@(color_2),@(color_3),@(color_4),@(color_5)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backImageView{
    UIImage *image=[UIImage imageNamed:@"activity_bg"];
    
    _backgroundImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, image.size.height)];
    _backgroundImgV.image=image;
    _backgroundImgV.userInteractionEnabled=YES;
    [self.view addSubview:_backgroundImgV];
    _backImgHeight=_backgroundImgV.frame.size.height;
    _backImgWidth=_backgroundImgV.frame.size.width;
}

-(void)createNaView
{
    CGFloat hig = [self headImageView].frame.size.height + NavHight;
    self.NavView=[[YYNavView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, hig)];
    self.NavView.title = @"活动列表";
    self.NavView.color = [UIColor whiteColor];
    self.NavView.left_bt_Image = @"custom_back_btn";
//    self.NavView.right_bt_Image = @"资源 33";
    self.NavView.delegate = self;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.NavView.frame)-titleBottom, CGRectGetWidth(self.view.frame), 20)];
    _titleLabel.font = [UIFont systemFontOfSize:20.f];
    _titleLabel.text = @"2017";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    [self.NavView addSubview:_titleLabel];
    
    [self.view addSubview:self.NavView];
}

-(void)layoutTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHight, WIDTH, HEIGHT-NavHight-1) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    [_tableView setTableHeaderView:[self headImageView]];
}


-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc]init];
        _headImageView.frame=CGRectMake(0, 0, WIDTH, 60);
        _headImageView.backgroundColor=[UIColor clearColor];
        _headImageView.userInteractionEnabled = YES;
        
//        _headerImg=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-35, 50, 70, 70)];
//        _headerImg.center=CGPointMake(WIDTH/2, 70);
//        [_headerImg setImage:[UIImage imageNamed:@"header"]];
//        [_headerImg.layer setMasksToBounds:YES];
//        [_headerImg.layer setCornerRadius:35];
//        _headerImg.backgroundColor=[UIColor whiteColor];
//        _headerImg.userInteractionEnabled=YES;
//        UITapGestureRecognizer *header_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(header_tap_Click:)];
//        [_headerImg addGestureRecognizer:header_tap];
//        [_headImageView addSubview:_headerImg];
//        
//        
//        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(147, 130, 105, 20)];
//        _nameLabel.center = CGPointMake(WIDTH/2, 125);
//        _nameLabel.text = @"Rainy";
//        _nameLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *nick_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nick_tap_Click:)];
//        [_nameLabel addGestureRecognizer:nick_tap];
//        _nameLabel.textColor=[UIColor whiteColor];
//        _nameLabel.textAlignment=NSTextAlignmentCenter;
//        [_headImageView addSubview:_nameLabel];
    }
    return _headImageView;
}

#pragma mark - activity
-(void)setM_pActivityList:(NSArray *)m_pActivityList
{
    _m_pActivityList = m_pActivityList;
    [_tableView reloadData];
}

//-(void)loadData{
//    
//    _dataArray =[[NSMutableArray alloc]init];
//    
//    for (int i = 0; i < 20; i++) {
//        
//        NSString * string=[NSString stringWithFormat:@"第%d行",i];
//        
//        [_dataArray addObject:string];
//        
//    }
//    
//}


//左按钮
-(void)NaLeft
{
    NSLog(@"左按钮");
    [self Back];
}
//右按钮
-(void)NaRight
{
    NSLog(@"右按钮");
}//头像
-(void)header_tap_Click:(UITapGestureRecognizer *)tap
{
    NSLog(@"头像");
}
//昵称
-(void)nick_tap_Click:(UIButton *)item
{
    NSLog(@"昵称");
}

#pragma mark ---- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _m_pActivityList.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180*[AppConfigure GetLengthAdaptRate];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YYActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[YYActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    YYActivityData *actData = _m_pActivityList[indexPath.row];
    [cell setData:actData];
    NSInteger xx = [_ColorArray[indexPath.row%5] integerValue];
    [cell setColor:UIColorFromHex(xx)];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YYActivityData *pData = _m_pActivityList[indexPath.row];
    YYRichTextDetailController *pXunDetailVC = [[YYRichTextDetailController alloc] init];
    pXunDetailVC.propContent = pData.content;
    [self PushChildViewController:pXunDetailVC];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    if (contentOffsety<0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-contentOffsety;
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{
        CGRect bgRect = _backgroundImgV.frame;
        bgRect.size.height = _backImgHeight;
        bgRect.size.width = _backImgWidth;
        bgRect.origin.x = 0;
        bgRect.origin.y = -contentOffsety;
        

        CGRect navRect = self.NavView.frame;
        navRect.size.height = _headImageView.frame.size.height + NavHight -contentOffsety;
        
        if (contentOffsety >=NavHight-50) {
            bgRect.origin.y = -NavHight+50;
            
        }
        if (navRect.size.height<NavHight) {
            navRect.size.height = NavHight;
        }
        
        CGRect labRect = _titleLabel.frame;
        labRect.origin.y =navRect.size.height-titleBottom;
        if (labRect.origin.y < NavHight-30) {
            labRect.origin.y = NavHight-30;
        }
        
        _backgroundImgV.frame = bgRect;
        [self.NavView setFrame:navRect];
        [_titleLabel setFrame:labRect];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
