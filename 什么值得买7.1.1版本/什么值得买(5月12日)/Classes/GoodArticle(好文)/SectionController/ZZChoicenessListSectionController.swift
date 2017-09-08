//
//  ZZChoicenessListSectionController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/8.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit
import IGListKit

class ZZChoicenessListSectionController: ListSectionController {
    
    var listModel: ZZListModel?
    
    override func numberOfItems() -> Int {
        if let count = listModel?.subItems.count {
            return count
        }
        return 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 270)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZChoicenessListCell",
                                                                bundle: nil,
                                                                for: self,
                                                                at: index) as? ZZChoicenessListCell else {
                                                                    fatalError()
        }
        if let list = listModel?.subItems as? [ZZChoicenessListModel] {
            cell.article = list[index].article?.first
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let model = object as? ZZListModel {
            listModel = model
        }
    }
}
