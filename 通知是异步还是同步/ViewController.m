//
//  ViewController.m
//  通知是异步还是同步
//
//  Created by 刘 on 2018/4/13.
//  Copyright © 2018年 刘. All rights reserved.
//

#import "ViewController.h"
#define TextNoti @"liutext"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 50, 50);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"text noti" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
//    注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:TextNoti object:nil];
    

    
    // Do any additional setup after loading the view, typically from a nib.
}


/**
接收通知
 */
- (void)receiveNoti:(NSNotification *)noti{
    NSString *message = noti.object;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"++++%@",message);
            sleep(3);
            NSLog(@"通知说话结束");

    });
//    NSLog(@"++++%@",message);
//    sleep(3);
//    NSLog(@"通知说话结束");
}


/**
 发送通知
 */
- (void)buttonDown{
  
    
    [[NSNotificationCenter defaultCenter]postNotificationName:TextNoti object:@"通知开始说话"];
//    修改为异步
    //将通知放入队列中，先进先出FIFO
    //NSPostWhenIdle 空闲时发送
    //NSPostASAP as soon as posible 尽快发送 当前runloop不是同一个mode,现等待一个runloop模式完后，就会执行通知事件
    //NSPostNow 马上执行
    
//    NSNotification *notifiction = [NSNotification notificationWithName:TextNoti object:@"通知开始说话"];
//    [[NSNotificationQueue defaultQueue] enqueueNotification:notifiction postingStyle:(NSPostWhenIdle)];
    NSLog(@"按钮说话");
}

/**
 移除通知
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TextNoti object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
