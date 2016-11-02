//
//  ViewController.m
//  testTextView
//
//  Created by ml  on 16/11/1.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;

@end

@implementation ViewController
//@synthesize bFrontFinish;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //[self.textView1 setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle1]];
    [_textView1 setBackgroundColor:[UIColor yellowColor]];
    NSLog(@"textView boundsSize=%f %f contentSize=%f %f",_textView1.bounds.size.width,_textView1.bounds.size.height,
          _textView1.contentSize.width,_textView1.contentSize.height);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePage:(id)sender {
    NSRange range=NSMakeRange(37+37, 1);
    [_textView1 scrollRangeToVisible:range];
    //[_textView scrollRectToVisible:CGRectMake(0, _textView.contentSize.height-15, _textView.contentSize.width, 10) animated:YES];
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
        
        
        int  nAveCountAline=[self getAveCountAline:self.textView1];
        int nHalfAveCountAline=nAveCountAline/2;
        
        NSDictionary *dict = @{NSForegroundColorAttributeName: [UIColor redColor]};
        UITextView* tv=self.textView1;
        // UITextPosition *beginning = tv.beginningOfDocument;
        int nIndex=0,nFrontIndex=0,nLastIndex = 0;
        int nCount=0,nFrontCount=0,nLastCount = 0;
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

- (IBAction)clickedBtn4:(id)sender {
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
        if(rect0.origin.y+rect0.size.height>tv.contentSize.height){
            //此行已经超出此页
            break;
        }
        else if (rect2.origin.y-rect0.origin.y>1) {
            //此行的最后一个字符
            lineCountAPage++;
        }
    }
    return lineCountAPage;
}
//检测第nIndex个字符是否是最后一行
- (int)isLastCharacterInLine:(UITextView*) tv index:(int)nIndex{
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
    NSLog(@"i=%d %@",nIndex,[tv.text substringWithRange:range]);
    
    CGRect rect0 = ((UITextSelectionRect *)arr[0]).rect;
    CGRect rect2 = ((UITextSelectionRect *)arr[2]).rect;
    
    NSTimeInterval time2=[NSDate timeIntervalSinceReferenceDate];
    NSLog(@"isLastCharacterInLine花费%f秒",time2-time1);
    return (rect2.origin.y-rect0.origin.y>1);
}

@end
