//
//  ViewController.m
//  testTextView
//
//  Created by ml  on 16/11/1.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableArray* arr;
    int _nTick;
    int _lineCountAPage;//每页行数
    int _contentOffsetHeight;//
}
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak ,nonatomic) NSTimer *timer;//进度更新定时器
@end

@implementation ViewController
//@synthesize bFrontFinish;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arr=[[NSMutableArray alloc]init];
    
    //[self.textView1 setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle1]];
    [_textView1 setBackgroundColor:[UIColor yellowColor]];
    _contentOffsetHeight=9;
     _textView1.contentOffset = CGPointMake(0, _contentOffsetHeight);
    //_textView1.contentInset = UIEdgeInsetsMake(30.0f, 30.0f, 30.0f, 30.0f);
    
    NSLog(@"textView boundsSize=%f %f contentSize=%f %f",_textView1.bounds.size.width,_textView1.bounds.size.height,
          _textView1.contentSize.width,_textView1.contentSize.height);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePage:(id)sender {
    //NSRange range=NSMakeRange(37+37, 1);
    //[_textView1 scrollRangeToVisible:range];
    //[_textView1 setContentOffset:CGPointMake(0, 90.5)];
    //_textView1.contentOffset = CGPointMake(0, 90.5);
    //[_textView scrollRectToVisible:CGRectMake(0, _textView.contentSize.height-15, _textView.contentSize.width, 10) animated:YES];
    [_textView1 setContentOffset:CGPointMake(0,_textView1.contentOffset.y+ _textView1.bounds.size.height)];

}
- (IBAction)HighLight:(id)sender {
    NSRange selectedRange = NSMakeRange(0, 3);
    //    NSDictionary *currentAttributesDict = [_textView1.textStorage attributesAtIndex:selectedRange.location
    //                                                                     effectiveRange:nil];
    //
    //    if ([currentAttributesDict objectForKey:NSForegroundColorAttributeName] == nil ||
    //        [currentAttributesDict objectForKey:NSForegroundColorAttributeName] != [UIColor redColor]) {
    
    NSDictionary *dict = @{NSForegroundColorAttributeName: [UIColor redColor]
                           };
    //        NSDictionary *dict2 = @{
    //                                NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]
    //                                };
    [_textView1.textStorage beginEditing];
    [_textView1.textStorage setAttributes:dict range:selectedRange];
    [_textView1.textStorage endEditing];
    //    }
    //    for (int i=0; i<238; i++) {
    //        NSRange range=NSMakeRange(i, 1);
    //        UITextPosition *beginning = _textView1.beginningOfDocument;
    //        UITextPosition *start = [_textView1 positionFromPosition:beginning offset:range.location];
    //        UITextPosition *end = [_textView1 positionFromPosition:start offset:range.length];
    //        UITextRange *textRange = [_textView1 textRangeFromPosition:start toPosition:end];
    //        NSArray* arr=[_textView1 selectionRectsForRange:textRange];
    //        NSLog(@"i=%d %@",i,[_textView1.text substringWithRange:range]);
    //        for (UITextSelectionRect *selectionRect in arr) {
    //            CGRect rect = selectionRect.rect;
    //            NSLog(@"rect=%f %f %f %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    //            //CGRect rect = ((UITextSelectionRect *)textrect[0]).rect;
    //            /*if (rect.size.width == 0 || rect.size.height == 0) continue;
    //             if (CGRectContainsPoint(rect, pt)) {
    //             selected = YES;
    //             break;
    //             }*/
    //            
    //        }
    //    }
    
}

- (IBAction)clickedBtn3:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        int nLineCountAPage=[self getLineCountAPage:self.textView1];//每月显示多少行
        int nAveCountAline=[self getAveCountAline:self.textView1];//每行平均多少字符
        int nHalfAveCountAline=nAveCountAline/2;
        
        NSDictionary *dict = @{NSForegroundColorAttributeName: [UIColor redColor]};
        UITextView* tv=self.textView1;
        // UITextPosition *beginning = tv.beginningOfDocument;
        int nIndex=0,nFrontIndex=0,nLastIndex = 0;
        int nCount=0,nFrontCount=0,nLastCount = 0;
        int nLineIndex=0;//行索引
        BOOL bFrontFinish=NO;//是否完成前半行扫描
        NSRange rangeFront=NSMakeRange(0, 0),rangeLast=NSMakeRange(0, 0);
        nFrontCount=nHalfAveCountAline;
        for (int i=0; i<tv.text.length; i++) {
            if (!bFrontFinish) {
                sleep(1);
                nFrontIndex=i;
                if (nFrontIndex+nFrontCount>tv.text.length) {
                    //扫描结束
                    break;
                }
                //前半行
                NSLog(@"rangeFront=%d,%d",nFrontIndex,nFrontCount);
                rangeFront=NSMakeRange(nFrontIndex, nFrontCount);
                
                nLineIndex++;//行+1
                if(nLineIndex>1&&(nLineIndex%nLineCountAPage==1)){
                    //需要翻页了
                    //    [_textView1 scrollRangeToVisible:rangeFront];
                    [_textView1 scrollRangeToVisible:NSMakeRange(32+10, 1)];
                    //[_textView1 scrollRangeToVisible:NSMakeRange((nLineIndex)*nLineCountAPage*nAveCountAline+2, 1)];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_textView1.textStorage beginEditing];//必须在主线程执行
                    [_textView1.textStorage removeAttribute:NSForegroundColorAttributeName range:rangeLast];//清掉后半行的颜色
                    [_textView1.textStorage addAttributes:dict range:rangeFront];//设置前半行的颜色
                    [_textView1.textStorage endEditing];
                });
                sleep(1);
                i+=nHalfAveCountAline-1;
                nLastCount=0;
                nLastIndex=i+1;
                bFrontFinish=!bFrontFinish;
                
            }
            else{
                nLastCount++;
                if(i==110){
                    NSLog(@"tttt");
                }
                if([self isLastCharacterInLine:tv index:i]){
                    //后半行
                    NSLog(@"rangeLast=%d,%d",nLastIndex,nLastCount);
                    
                    rangeLast=NSMakeRange(nLastIndex, nLastCount);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_textView1.textStorage beginEditing];//必须在主线程执行
                        [_textView1.textStorage removeAttribute:NSForegroundColorAttributeName range:rangeFront];//清掉前半行的颜色
                        [_textView1.textStorage addAttributes:dict range:rangeLast];//设置后半行的颜色
                        [_textView1.textStorage endEditing];
                    });
                    bFrontFinish=!bFrontFinish;
                }
            }
        }
        
    });
}
//获取平均每行字符数
//获取每页行数
//每半行插入数组中
- (IBAction)clickedBtn4:(id)sender {
    int aveCountAline=0;//平均每行字符数
    int aveHalfCountALine=0;//平均半行字符数
    
    int j=0;
    int count_thisline=0;//此行字符数
    UITextView* tv=self.textView1;
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
        if (rect2.origin.y-rect0.origin.y>1) {
            NSUInteger locF=MAX(0,i-count_thisline+1);
            //此行的最后一个字符
            if(aveCountAline==0){
                aveCountAline=i+1;
                aveHalfCountALine=aveCountAline/2;
                locF=MAX(0,i-count_thisline);
            }
            if (_lineCountAPage==0) {
                j++;
                if(rect2.origin.y+rect2.size.height>tv.bounds.size.height+_contentOffsetHeight){
                    //此页的最后一行的最后一个字符
                    _lineCountAPage=j;
                }
            }
            //将每半行区间插入数组中
            NSUInteger lenF=aveHalfCountALine;
            NSUInteger locL=locF+aveHalfCountALine;
            NSUInteger lenL=MAX(0, count_thisline-lenF);
            NSRange rangeF= NSMakeRange(locF, lenF);
            NSRange rangeL= NSMakeRange(locL, lenL);
            char *type=@encode(NSRange);
            [arr addObject:[NSValue value:&rangeF withObjCType:type]];
            [arr addObject:[NSValue value:&rangeL withObjCType:type]];
            count_thisline=0;
        }
    }
}

- (IBAction)clickedBtn5:(id)sender {
    _nTick=0;
    self.timer.fireDate=[NSDate distantPast];//恢复定时器
    
    //self.timer.fireDate=[NSDate distantFuture];//暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
}
- (IBAction)clickedBtn6:(id)sender {
}
-(void)updateProgress{
    if (_nTick+1>=arr.count) {
        NSLog(@"结束了");
        return;
    }
    //自动翻页
    if (_nTick!=0&&((_nTick+1)%(_lineCountAPage*2))==0) {
        [_textView1 setContentOffset:CGPointMake(0, _textView1.contentOffset.y+_textView1.bounds.size.height)];
    }
    
    NSRange rangeFront,rangeLast;
    [[arr objectAtIndex:_nTick]getValue:&rangeFront];
    [[arr objectAtIndex:_nTick+1]getValue:&rangeLast];
    
    NSDictionary *dict = @{NSForegroundColorAttributeName: [UIColor redColor]};
    [_textView1.textStorage beginEditing];//必须在主线程执行
    [_textView1.textStorage removeAttribute:NSForegroundColorAttributeName range:rangeFront];//清掉后半行的颜色
    [_textView1.textStorage addAttributes:dict range:rangeLast];//设置前半行的颜色
    [_textView1.textStorage endEditing];
    _nTick++;
}
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:true];
    }
    return _timer;
}
//获取平均每行字符数
//根据第1行获取
- (int)getAveCountAline:(UITextView*) tv{
    __block int aveCountAline=0;
   // dispatch_async(dispatch_get_main_queue(), ^{
 //       @synchronized (tv) {
            UITextPosition *beginning = tv.beginningOfDocument;
            for (int i=0; i<tv.text.length; i++) {
                NSRange range=NSMakeRange(i, 1);
                UITextPosition *start = [tv positionFromPosition:beginning offset:range.location];
                UITextPosition *end = [tv positionFromPosition:start offset:range.length];
                UITextRange *textRange = [tv textRangeFromPosition:start toPosition:end];
                NSArray* arr=[tv selectionRectsForRange:textRange];
                NSLog(@"i=%d %@",i,[tv.text substringWithRange:range]);
                CGRect rect0 = ((UITextSelectionRect *)arr[0]).rect;
                CGRect rect2 = ((UITextSelectionRect *)arr[2]).rect;
                if (rect2.origin.y-rect0.origin.y>1) {
                    //此行的最后一个字符
                    aveCountAline=i+1;
                    break;
                }
            }
 //       }
        
  //  });
    return aveCountAline;
}
//获取每页行数
//根据文字的左边判断是否显示完全
- (int)getLineCountAPage:(UITextView*) tv
{
    int lineCountAPage=1;
    UITextPosition *beginning = tv.beginningOfDocument;
    for (int i=0; i<tv.text.length; i++) {
        NSRange range=NSMakeRange(i, 1);
        UITextPosition *start = [tv positionFromPosition:beginning offset:range.location];
        UITextPosition *end = [tv positionFromPosition:start offset:range.length];
        UITextRange *textRange = [tv textRangeFromPosition:start toPosition:end];
        NSArray* arr=[tv selectionRectsForRange:textRange];
        NSLog(@"i=%d %@",i,[tv.text substringWithRange:range]);
        CGRect rect0 = ((UITextSelectionRect *)arr[0]).rect;
        CGRect rect2 = ((UITextSelectionRect *)arr[2]).rect;
        if(rect0.origin.y+rect0.size.height>tv.bounds.size.height){
            //此行已经超出此页
            break;
        }
        else if (rect2.origin.y-rect0.origin.y>1) {
            //此行的最后一个字符
            lineCountAPage++;
        }
    }
    return lineCountAPage-1;
}
//检测第nIndex个字符是否是此行最后一个字符
- (BOOL)isLastCharacterInLine:(UITextView*) tv index:(int)nIndex{
    NSTimeInterval time1=[NSDate timeIntervalSinceReferenceDate];
    UITextPosition *beginning = tv.beginningOfDocument;
    NSRange range=NSMakeRange(nIndex, 1);
    UITextPosition *start = [tv positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [tv positionFromPosition:start offset:range.length];
    UITextRange *textRange = [tv textRangeFromPosition:start toPosition:end];
    
    NSTimeInterval time3=[NSDate timeIntervalSinceReferenceDate];
    __block NSArray* arr=nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        arr=[tv selectionRectsForRange:textRange];//必须放在主线程，否则有时会出错
    });
    NSTimeInterval time4=[NSDate timeIntervalSinceReferenceDate];
    NSLog(@"selectionRectsForRange花费%f秒",time4-time3);
    
    
    CGRect rect0 = ((UITextSelectionRect *)arr[0]).rect;
    CGRect rect2 = ((UITextSelectionRect *)arr[2]).rect;
    NSLog(@"i=%d %@ %f %f",nIndex,[tv.text substringWithRange:range],rect0.size.width,rect0.size.height);
    NSTimeInterval time2=[NSDate timeIntervalSinceReferenceDate];
    NSLog(@"isLastCharacterInLine花费%f秒",time2-time1);
    return (rect2.origin.y-rect0.origin.y>1);
}
@end
