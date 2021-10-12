//
//  YYBBBaseListSectionController.m
//  
//
//  Created by Wang_Ruzhou on 9/17/19.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseListSectionController.h"

@implementation YYBBBaseListSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return self.listModel.subItems.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    
    if (CGSizeEqualToSize(self.listModel.itemSize, CGSizeZero)) {
        IGListAdapter *adapter = self.collectionContext;
        UICollectionViewFlowLayout *flowLayout = adapter.collectionView.collectionViewLayout;
        CGFloat temp = 0;
        if (flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            temp = self.collectionContext.containerSize.width - self.listModel.inset.left - self.listModel.inset.right - self.listModel.minimumInteritemSpacing * (self.listModel.columns - 1);
        } else {
            temp = self.collectionContext.containerSize.width - self.listModel.inset.left - self.listModel.inset.right - self.listModel.minimumLineSpacing * (self.listModel.columns - 1);
        }
        
        CGFloat width = floor(temp) / self.listModel.columns;
        return CGSizeMake(floor(width), self.listModel.itemHeight);
    }
    
    return self.listModel.itemSize;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    Class cellClass = NSClassFromString(self.listModel.cellClass);
    if (self.listModel.cellNibLoad) {
        UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass(cellClass)
                                                                                     bundle:nil
                                                                       forSectionController:self
                                                                                    atIndex:index];
        return cell;
    } else {
        UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass
                                                                   forSectionController:self
                                                                                atIndex:index];
        return cell;
    }

}

- (NSArray<NSString *> *)supportedElementKinds {
    return self.listModel.supportedElementKinds;
}


- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        Class class = NSClassFromString(self.listModel.supplementaryHeaderViewClass);
        if ([self.listModel.supportedElementKinds containsObject:UICollectionElementKindSectionHeader] && class) {
            if (self.listModel.headerViewNibLoad) {
                UICollectionReusableView *headerView = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                       forSectionController:self
                                                                                                    nibName:NSStringFromClass(class)
                                                                                                     bundle:nil
                                                                                                    atIndex:index];
                return headerView;
            } else {
                UICollectionReusableView *headerView = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                 forSectionController:self
                                                                                                                class:class
                                                                                                              atIndex:index];
                return headerView;
            }

        }
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        Class class = NSClassFromString(self.listModel.supplementaryFooterViewClass);
        if ([self.listModel.supportedElementKinds containsObject:UICollectionElementKindSectionFooter] && class) {
            if (self.listModel.footerViewNibLoad) {
                UICollectionReusableView *footerView = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                       forSectionController:self
                                                                                                    nibName:NSStringFromClass(class)
                                                                                                     bundle:nil
                                                                                                    atIndex:index];
                return footerView;
            } else {
                UICollectionReusableView *footerView = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                                 forSectionController:self
                                                                                                                class:class
                                                                                                              atIndex:index];
                return footerView;
            }
        }
    }
    return nil;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        Class class = NSClassFromString(self.listModel.supplementaryHeaderViewClass);
        if ([self.listModel.supportedElementKinds containsObject:UICollectionElementKindSectionHeader] && class) {
            CGFloat width = self.collectionContext.containerSize.width - self.listModel.inset.left - self.listModel.inset.right;
            return CGSizeMake(floor(width), self.listModel.sectionHeaderHeight);
        }
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        Class class = NSClassFromString(self.listModel.supplementaryFooterViewClass);
        if ([self.listModel.supportedElementKinds containsObject:UICollectionElementKindSectionFooter] && class) {
            CGFloat width = self.collectionContext.containerSize.width - self.listModel.inset.left - self.listModel.inset.right;
            return CGSizeMake(floor(width), self.listModel.sectionFooterHeight);
        }
    }
    return CGSizeZero;
}

- (void)didUpdateToObject:(id)object {
    if ([object isKindOfClass:[YYBBSectionListModel class]]) {
        self.listModel = object;
    }
}

@end
