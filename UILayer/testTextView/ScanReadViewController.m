//
//  ScanReadViewController.m
//  testTextView
//
//  Created by gxl on 16/11/11.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "ScanReadViewController.h"

@interface ScanReadViewController (){
    NSMutableArray* _arr;
    int _nTick;
    int _lineCountAPage;//每页行数
    int _contentOffsetHeight;//
}
@property (weak ,nonatomic) NSTimer *timer;//进度更新定时器
@end

@implementation ScanReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _arr=[[NSMutableArray alloc]init];
    [_tvArticle setBackgroundColor:[UIColor yellowColor]];
    _contentOffsetHeight=9;
    _tvArticle.contentOffset = CGPointMake(0, _contentOffsetHeight);
    _nTick=0;
    _tvArticle.text=_article.Content;
    [self calculate];
    self.timer.fireDate=[NSDate distantPast];//恢复定时器
    
    //self.timer.fireDate=[NSDate distantFuture];//暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取平均每行字符数
//获取每页行数
//每半行插入数组中
- (void)calculate{
    int aveCountAline=0;//平均每行字符数
    int aveHalfCountALine=0;//平均半行字符数
    
    int j=0;
    int count_thisline=0;//此行字符数
    UITextView* tv=self.tvArticle;
    UITextPosition *beginning = tv.beginningOfDocument;
    for (int i=0; i<tv.text.length; i++) {
        count_thisline++;
        NSRange range=NSMakeRange(i, 1);
        UITextPosition *start = [tv positionFromPosition:beginning offset:range.location];
        UITextPosition *end = [tv positionFromPosition:start offset:range.length];
        UITextRange *textRange = [tv textRangeFromPosition:start toPosition:end];
        NSArray* arr1=[tv selectionRectsForRange:textRange];
        CGRect rect0 = ((UITextSelectionRect *)arr1[0]).rect;
        CGRect rect2 = ((UITextSelectionRect *)arr1[2]).rect;
        NSLog(@"i=%d %@,rect0=%f %f %f %f  rect2=%f %f %f %f",i,[tv.text substringWithRange:range],
              rect0.origin.x,rect0.origin.y,rect0.size.width,rect0.size.height,
              rect2.origin.x,rect2.origin.y,rect2.size.width,rect2.size.height);
        if ((rect2.origin.y-rect0.origin.y>1)&&(rect2.origin.y-rect0.origin.y<999))
        {
            NSUInteger locF=MAX(0,(int)(i-count_thisline+1));
            //此行的最后一个字符
            if(aveCountAline==0){
                aveCountAline=i+1;
                aveHalfCountALine=aveCountAline/2;
                locF=MAX(0,(int)(i-count_thisline));
            }
            if (_lineCountAPage==0) {
                j++;
                if(rect2.origin.y+rect2.size.height>tv.bounds.size.height+_contentOffsetHeight){
                    //此页的最后一行的最后一个字符
                    _lineCountAPage=j;
                }
            }
            if (i==2) {
                NSLog(@"test");
            }
            //将每半行区间插入数组中
            NSUInteger lenF=MIN(aveHalfCountALine,count_thisline);
            NSUInteger locL=locF+aveHalfCountALine;
            NSUInteger lenL=MAX(0, (int)(count_thisline-lenF));
            NSRange rangeF= NSMakeRange(locF, lenF);
            NSRange rangeL= NSMakeRange(locL, lenL);
            char *type=@encode(NSRange);
            [_arr addObject:[NSValue value:&rangeF withObjCType:type]];
            [_arr addObject:[NSValue value:&rangeL withObjCType:type]];
            count_thisline=0;
        }
    }
}

-(void)updateProgress{
    if (_nTick+1>=_arr.count) {
        NSLog(@"结束了");
        return;
    }
    //自动翻页
    if (_nTick!=0&&((_nTick+1)%(_lineCountAPage*2))==0) {
        [_tvArticle setContentOffset:CGPointMake(0, _tvArticle.contentOffset.y+_tvArticle.bounds.size.height)];
    }
    
    NSRange rangeFront,rangeLast;
    [[_arr objectAtIndex:_nTick]getValue:&rangeFront];
    [[_arr objectAtIndex:_nTick+1]getValue:&rangeLast];
    NSDictionary *dict = @{NSForegroundColorAttributeName: [UIColor redColor]};
    [_tvArticle.textStorage beginEditing];//必须在主线程执行
    [_tvArticle.textStorage removeAttribute:NSForegroundColorAttributeName range:rangeFront];//清掉后半行的颜色
    [_tvArticle.textStorage addAttributes:dict range:rangeLast];//设置前半行的颜色
    [_tvArticle.textStorage endEditing];
    _nTick++;
}

-(void)updateProgress2{
   // CGAffineTransform t= CGAffineTransformMakeTranslation (_tvArticle.frame.origin.x , 1);
   // _tvArticle.transform=t;
   //      _tvArticle.transform = CGAffineTransformMakeTranslation(10.0f, 0.0f);
    
//    [UIView animateWithDuration:0.5 animations:^{
    
    _tvArticle.transform = CGAffineTransformMakeTranslation(0, _nTick%2==0?100:30);
    
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            
//            _tvArticle.transform = CGAffineTransformMakeTranslation(0, 30);
//            
//            
//        } completion:^(BOOL finished) {
//            
//        }];
//        
//        
//    }];
    _nTick++;
}
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress2) userInfo:nil repeats:true];
    }
    return _timer;
}
//改变字体大小
-(void)changeFontSize{
    //[self.myTextView setFont:[UIFont fontWithOfSize:14]];
    //[myTextView setFont:[UIFont fontWithName:@"Arial" size:Fontsize]];
}
//获取字体名称列表
-(void)getFontName{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

@end
