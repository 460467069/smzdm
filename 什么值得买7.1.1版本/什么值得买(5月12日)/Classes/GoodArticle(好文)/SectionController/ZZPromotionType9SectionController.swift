//
//  ZZPromotionType9SectionController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/24.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZPromotionType9SectionController: ZZPromotionType6SectionController {
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZPromotionType9SubCell",
                                                                bundle: nil,
                                                                for: self,
                                                                at: index) as? ZZPromotionType9SubCell else {
                                                                    fatalError()
        }
        let list = listModel?.subItems as! [ZZTopicArticleModel]
        cell.article = list[index]
        return cell
    }
}
