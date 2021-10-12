//
//  UIView+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 5/5/19.
//

#import "UIScrollView+YYBBAdd.h"
#import <YYCategories/UIView+YYAdd.h>

@implementation UIScrollView (YYBBAdd)

- (nullable UIImage *)yybb_snapshotImage {
    CGPoint savedContentOffset = self.contentOffset;
    CGRect savedFrame = self.frame;
    
    self.contentOffset = CGPointZero;
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    UIImage* image = [self snapshotImage];
    self.contentOffset = savedContentOffset;
    self.frame = savedFrame;
    return image;
}

@end
