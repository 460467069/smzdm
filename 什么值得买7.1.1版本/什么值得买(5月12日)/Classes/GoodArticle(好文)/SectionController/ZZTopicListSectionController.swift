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

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZTopicListCell",
                                                                bundle: nil,
                                                                for: self,
                                                                at: index) as? ZZTopicListCell else {
            fatalError()
        }
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        
    }
}
