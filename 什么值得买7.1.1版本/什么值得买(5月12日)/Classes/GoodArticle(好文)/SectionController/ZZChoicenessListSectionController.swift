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
        let list = listModel?.subItems as! [ZZChoicenessListModel]
        let choicenessModel = list[index]
        let cellType = choicenessModel.cell_type
        var height:CGFloat = 270
        if cellType == "41" {
            height = 200
        } else if cellType == "30" {
            height = 150
        } else if cellType == "38" {
            height = 150
        }
        return CGSize(width: collectionContext!.containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let list = listModel?.subItems as! [ZZChoicenessListModel]
        let choicenessModel = list[index]
        let cellType = choicenessModel.cell_type
        if cellType == "41" {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZType41Cell",
                                                                    bundle: nil,
                                                                    for: self,
                                                                    at: index) as? ZZType41Cell else {
                                                                        fatalError()
            }
            
            cell.choicenessModel = choicenessModel
            return cell
            
        } else if cellType == "30" {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZType30Cell",
                                                                    bundle: nil,
                                                                    for: self,
                                                                    at: index) as? ZZType30Cell else {
                                                                        fatalError()
            }
            cell.article = choicenessModel.article?.first
            return cell
        } else if cellType == "38" {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZType38Cell",
                                                                    bundle: nil,
                                                                    for: self,
                                                                    at: index) as? ZZType38Cell else {
                                                                        fatalError()
            }
            cell.choicenessModel = choicenessModel
            return cell
        }
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZChoicenessListCell",
                                                                bundle: nil,
                                                                for: self,
                                                                at: index) as? ZZChoicenessListCell else {
                                                                    fatalError()
        }
        cell.article = choicenessModel.article?.first
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let model = object as? ZZListModel {
            listModel = model
        }
    }
}
