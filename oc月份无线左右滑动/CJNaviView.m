//
//  CJNaviView.m
//  segmentedControl
//
//  Created by 王玉松 on 2024/9/29.
//

#import "CJNaviView.h"
#define Color_Hex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define kSelectedColor [UIColor grayColor]
#define kNormalColor   [UIColor lightGrayColor]
// Button进行封装
@interface CJNaviButton:UIButton

@property (nonatomic, weak) UIView *lineView;

@end

@implementation CJNaviButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat lineWidth = 3;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - lineWidth, frame.size.width, lineWidth)];
        // 设置初始状态
        lineView.backgroundColor = kNormalColor;
        lineView.hidden = YES;
        _lineView = lineView;
        [self setTitleColor:kNormalColor forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:lineView];
        
    }
    return self;
}



@end

@interface CJNaviView()

@property (nonatomic, weak) id<CJNaviViewDelegate> delegate;

@property (nonatomic, strong) CJNaviButton *lastClickButton;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@end

@implementation CJNaviView
/**
 *  init方法
 *
 *  @param titles   title数组 :@[@"选项1",@"选项2"]
 *  @param frame    整个naviView frame
 *  @param delegate 设置代理
 *
 *  @return CJNaviView实例
 */
- (instancetype)initWithNumberOfTitles:(NSArray *)titles andFrame:(CGRect)frame delegate:(id<CJNaviViewDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [Color_Hex(0X444CB9) colorWithAlphaComponent:0.18];
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        // 设置代理
        self.delegate = delegate;
        CGFloat buttonWidth = (frame.size.width - 16) / titles.count;

        for (int i = 0; i < titles.count; i ++) {
            CJNaviButton *button = [[CJNaviButton alloc] initWithFrame:CGRectMake(i *buttonWidth + i*4 + 4, (frame.size.height-32)/2, buttonWidth, 32)];

            button.backgroundColor = UIColor.clearColor;
            [button setTitleColor:Color_Hex(0X202A33) forState:(UIControlStateNormal)];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            // 默认选中第一个 设置状态
            if (i == 0) {
//                button.lineView.backgroundColor = kSelectedColor;
                [self setButtonBgColor:button];
                // 保留为上次选择中的button
                _lastClickButton = button;
            }
            // 设置对应的tag
            button.tag = i;
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(A_choosed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(buttonWidth + 4, 15, 2, 10)];
        line1.backgroundColor = [Color_Hex(0X000000) colorWithAlphaComponent:0.1];
        self.line1 = line1;
        line1.hidden = YES;
        [self addSubview:line1];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake((buttonWidth + 4) *2, 15, 2, 10)];
        line2.backgroundColor = [Color_Hex(0X000000) colorWithAlphaComponent:0.1];
        self.line2 = line2;
        [self addSubview:line2];
    }
    
    
    
    return self;
    
}


- (void)setButtonBgColor:(CJNaviButton *)button{
    button.backgroundColor = [Color_Hex(0X070F48) colorWithAlphaComponent:0.18];
    button.layer.shadowColor = [[Color_Hex(0X919191) colorWithAlphaComponent:0.25] CGColor]; // 阴影颜色
    button.layer.shadowOffset = CGSizeMake(0, 0); // 阴影偏移量 (水平偏移, 垂直偏移)
//    button.layer.shadowOpacity = 1.0; // 阴影不透明度
    button.layer.shadowRadius = 4; // 阴影模糊半径
    button.layer.cornerRadius = 16;
    button.layer.masksToBounds = YES;
}

- (void)A_choosed:(CJNaviButton *)button{
    
    if (button.tag == 0) {
        self.line1.hidden = YES;
        self.line2.hidden = NO;
    }else if (button.tag == 1){
        self.line1.hidden = YES;
        self.line2.hidden = YES;
    }else if (button.tag == 2){
        self.line1.hidden = NO;
        self.line2.hidden = YES;
    }
    // 连续点击同一个不响应回调
//    if (_lastClickButton != button) {
        _lastClickButton.backgroundColor = [UIColor clearColor];
        [self setButtonBgColor:button];
        // 设置状态
//        [button setTitleColor:kSelectedColor forState:UIControlStateNormal];
//        button.backgroundColor = kSelectedColor;
//        [_lastClickButton setTitleColor:kNormalColor forState:UIControlStateNormal];
//        _lastClickButton.backgroundColor = kNormalColor;
        
        _lastClickButton = button;
        // 回调 可用block
        if ([self.delegate respondsToSelector:@selector(D_selectedTag:)]) {
            [self.delegate D_selectedTag:button.tag];
        }
//    }
}
@end
