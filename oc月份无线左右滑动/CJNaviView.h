//
//  CJNaviView.h
//  segmentedControl
//
//  Created by 王玉松 on 2024/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CJNaviViewDelegate <NSObject>

- (void)D_selectedTag:(NSInteger)tag;

@end

@interface CJNaviView : UIView


- (instancetype)initWithNumberOfTitles:(NSArray *)titles andFrame:(CGRect)frame delegate:(id<CJNaviViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
