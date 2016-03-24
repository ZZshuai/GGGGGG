//
//  DoodleView.m
//  Draw - 马朋飞
//
//  Created by laouhn on 15/11/26.
//  Copyright (c) 2015年 laouhn. All rights reserved.
//

#import "DoodleView.h"

@implementation DoodleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lineArray = [NSMutableArray array];
    }
    return self;
}
//每一次触摸都会有一个点,开始触摸的时候记录这个点
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //创建点数组
    NSMutableArray *pointArray = [NSMutableArray arrayWithCapacity:0];
    //添加到大数组中
    [self.lineArray addObject:pointArray];
    // 重绘界面(不重绘,一个界面只能画一次)
//    [self setNeedsDisplay];
}
//当触摸一直进行时记录过程中的点
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //拿到手指对象
    UITouch *touch = [touches anyObject];
    //获得触摸的点
    CGPoint point = [touch locationInView:self];
    NSLog(@"point = %@", NSStringFromCGPoint(point));
    //拿到大数组中最后的点数组
    NSMutableArray *pointArray = [self.lineArray lastObject];
    //数组只能存储对象,所以应该将点转换成对象
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    [pointArray addObject:pointValue];
    // 重绘界面(不重绘,一个界面只能画一次)
    [self setNeedsDisplay];
    
    
}

//当View修改fram时会被调用,如果想要绘图,需要重写这个方法
- (void)drawRect:(CGRect)rect {
    //得到上下文(画笔的一些基本设置)
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //或者
//    CGContextSetRGBStrokeColor(context, 0, 1, 0.1, 1);
    //设置画笔粗细
    CGContextSetLineWidth(context, 5.0);
    //根据路径绘图,所以要便利所有的点,上一个点和下一个点组成路径
    for (int i = 0; i < self.lineArray.count; i++) {
        NSMutableArray *pointArray = self.lineArray[i];
        //这里要注意数组越界问题
        if (pointArray.count > 1) {
            for (int j = 0; j < pointArray.count - 1; j++) {
                //数组里存储的是对象,所以想要得到点需要转换类型
                NSValue *firstPointValue = pointArray[j];
                NSValue *secondPointValue = pointArray[j + 1];
                CGPoint firstPoint = [firstPointValue CGPointValue];
                CGPoint secondPoint = [secondPointValue CGPointValue];
                //把笔触移动到一个点
                CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
                //笔触和另一个点要形成一个路径
                CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
            }
        }
    }
    //设置绘图模式
    CGContextDrawPath(context, kCGPathStroke);
    //绘制
    CGContextStrokePath(context);
    
    
    //2.画圆弧
        // x\y : 圆心
        // radius : 半径
        // startAngle : 开始角度
        // endAngle : 结束角度
        // clockwise : 圆弧的伸展方向(0:顺时针, 1:逆时针)
    CGContextAddArc(context, 100, 200, 50, M_PI_2, M_PI, 0);
    //显示绘制的内容
    CGContextFillPath(context);
    
    
    //3.画圆
    CGContextAddEllipseInRect(context, CGRectMake(150, 300, 100, 100));
//    CGContextSetLineWidth(context, 20.0);
    //绘制
    CGContextStrokePath(context);
    
    
    //4.画矩形
    CGContextAddRect(context, CGRectMake(150, 200, 80, 80));
        // set : 同时设置为实心和空心颜色
        // setStroke : 设置空心颜色
        // setFill : 设置实心颜色
        [[UIColor redColor] setStroke];
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //绘制
    CGContextFillPath(context);
    
    
    //5.画三角形
    CGContextMoveToPoint(context, 30, 30);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 150, 80);
    //连接起点和最后一个点
    CGContextClosePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //绘制
    CGContextStrokePath(context);
    
    
    //6.画文字
        // 1.画矩形
        CGRect cubeRect = CGRectMake(150, 200, 80, 80);
        // 2.显示所绘制的东西
        NSString *str = @"哈哈哈哈";
    
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        // NSForegroundColorAttributeName : 文字颜色
        // NSFontAttributeName : 字体
        attrs[NSForegroundColorAttributeName] = [UIColor redColor];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        [str drawInRect:cubeRect withAttributes:attrs];
        CGContextFillPath(context);
    
    //7.画图片
        // 1.取得图片
        UIImage *image = [UIImage imageNamed:@"16757045_1283491640Hsq8"];
    
        // 2.画
        //    [image drawAtPoint:CGPointMake(50, 50)];
        //    [image drawInRect:CGRectMake(0, 0, 150, 150)];
        [image drawAsPatternInRect:CGRectMake(200, 64, 100, 60)];
    
        // 3.画文字
        NSString *strl = @"为xxx所画";
        [strl drawInRect:CGRectMake(200, 50, 60, 30) withAttributes:nil];
    
    
    
    
    
    
    
    
}

@end
