//
//  ZZPromotionType6SectionController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/20.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit
import IGListKit

class ZZPromotionType6SectionController: ListSectionController {
    override init() {
        super.init()
        self.inset = UIEdgeInsetsMake(0, 10, 0, 10)
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
    }
    var listModel: ZZListModel?
    override func numberOfItems() -> Int {
        if let count = listModel?.subItems.count {
            return count
        }
        return 0
    }
    override func sizeForItem(at index: Int) -> CGSize {
        let height = collectionContext?.containerSize.height ?? 0
        return CGSize(width: 130, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZPromotionType6SubCell",
                                                                bundle: nil,
                                                                for: self,
                                                                at: index) as? ZZPromotionType6SubCell else {
                                                                    fatalError()
        }
        let list = listModel?.subItems as! [ZZWorthyArticle]
        cell.article = list[index]
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let model = object as? ZZListModel {
            listModel = model
        }
    }
}
