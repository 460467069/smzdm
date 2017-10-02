//
//  ZZLittleBannerSectionController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/10/3.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import IGListKit

fileprivate let kItems: CGFloat = 5

class ZZLittleBannerSectionController: ListSectionController {
    var listModel: ZZListModel?
    override init() {
        super.init()
        
    }
    override func numberOfItems() -> Int {
        if let count = listModel?.subItems?.count {
            return count
        }
        return 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width / kItems
        return CGSize(width: width, height: 80)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let list = listModel?.subItems as! [ZZLittleBanner]
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZLittleBannerCell",
                                                                bundle: nil,
                                                                for: self,
                                                                at: index) as? ZZLittleBannerCell else {
                                                                    fatalError()
        }
        cell.littleBanner = list[index]
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        if let model = object as? ZZListModel {
            listModel = model
        }
    }
}


