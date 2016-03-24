//
//  ViewController.m
//  Draw - 马朋飞
//
//  Created by laouhn on 15/11/26.
//  Copyright (c) 2015年 laouhn. All rights reserved.
//

#import "ViewController.h"
#import "DoodleView.h"

@interface ViewController ()
@property (nonatomic, strong)DoodleView *lineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.lineView = [[DoodleView alloc] initWithFrame:self.view.bounds];
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineView];
}
- (IBAction)removeAllObjeict:(id)sender {
    [self.lineView.lineArray removeAllObjects];
    //重绘
    [self.lineView setNeedsDisplay];
}
- (IBAction)removePreviousObjeict:(id)sender {
    [self.lineView.lineArray removeLastObject];
    //重绘
    [self.lineView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
