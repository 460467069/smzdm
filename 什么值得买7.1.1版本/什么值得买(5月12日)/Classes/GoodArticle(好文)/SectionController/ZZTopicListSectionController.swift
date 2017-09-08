//
//  ZZTopicListSectionController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/8/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit
import IGListKit

class ZZTopicListSectionController: ListSectionController {

    var topicListModel: ZZHaoWenTopicListModel?
    
    override func numberOfItems() -> Int {
        if let count = topicListModel?.rows?.count {
            return count
        }
        return 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 120)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZTopicListCell",
                                                                bundle: nil,
                                                                for: self,
                                                                at: index) as? ZZTopicListCell else {
            fatalError()
        }
        cell.article = topicListModel?.rows?[index]
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        if let model = object as? ZZHaoWenTopicListModel {
            topicListModel = model
        }
    }
}
