//
//  ToolCommon.m
//  testTextView
//
//  Created by gxl on 16/11/5.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "ToolCommon.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
@implementation ToolCommon{
    AVAudioPlayer* _player;
}
static ToolCommon *sharedManager = nil;

+ (ToolCommon*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[super alloc] init];
        
    });
    return sharedManager;
}

-(void)playMusic{
    if(!_player)
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"丹田冥想呼吸引领" ofType:@"mp3"]] error:nil];
    if(!_player.isPlaying)
        [_player play];
}
-(void)stopMusic{
    if(_player)
        if(_player.isPlaying)
             [_player stop];
}
@end
