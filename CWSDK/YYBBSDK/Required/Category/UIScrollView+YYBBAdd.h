//
//  UIView+YYBBAdd.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 5/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (YYBBAdd)

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)yybb_snapshotImage;


@end

NS_ASSUME_NONNULL_END
