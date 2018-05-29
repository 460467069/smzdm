//
//  ZZAdSectionController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/10/3.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import IGListKit

class ZZAdSectionController: ListSectionController {
    var listModel: ZZListModel?
    override init() {
        super.init()
    }
    override func numberOfItems() -> Int {
        if let _ = listModel?.subItems?.count {
            return 1
        }
        return 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: screenAdaptation(fromPixelValue: 306))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let list = listModel?.subItems as! [ZZLittleBanner]
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZADCollectionViewCell",
                                                                bundle: nil,
                                                                for: self,
                                                                at: index) as? ZZADCollectionViewCell else {
                                                                    fatalError()
        }
        var urls = [String]()
        for model in list {
            urls.append(model.img)
        }
        cell.cycleScrollView.imageURLStringsGroup = urls
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        if let model = object as? ZZListModel {
            listModel = model
        }
    }
}

