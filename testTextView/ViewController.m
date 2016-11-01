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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
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
    for (int i=0; i<38; i++) {
        NSRange range=NSMakeRange(i, 1);
        UITextPosition *beginning = _textView1.beginningOfDocument;
        UITextPosition *start = [_textView1 positionFromPosition:beginning offset:range.location];
        UITextPosition *end = [_textView1 positionFromPosition:start offset:range.length];
        UITextRange *textRange = [_textView1 textRangeFromPosition:start toPosition:end];
        NSArray* arr=[_textView1 selectionRectsForRange:textRange];
        NSLog(@"i=%d %@",i,[_textView1.text substringWithRange:range]);
        for (UITextSelectionRect *selectionRect in arr) {
            CGRect rect = selectionRect.rect;
            NSLog(@"rect=%f %f %f %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
            //CGRect rect = ((UITextSelectionRect *)textrect[0]).rect;
            /*if (rect.size.width == 0 || rect.size.height == 0) continue;
             if (CGRectContainsPoint(rect, pt)) {
             selected = YES;
             break;
             }*/
            
        }
    }

}

@end
