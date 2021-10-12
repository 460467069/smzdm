//
//  ZZTopicListSectionController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/8/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit
import IGListKit

class ZZTopicListSectionController: ListSectionController, ListSupplementaryViewSource {
    var topicListModel: ZZHaoWenTopicListModel?
    override init() {
        super.init()
        supplementaryViewSource = self
    }
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
    
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             for: self,
                                                                             nibName: "ZZTopicHeaderView",
                                                                             bundle: nil,
                                                                             at: index) as? ZZTopicHeaderView else {
                                                                                fatalError()
        }
        view.titleLabel.text = topicListModel?.title
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 60)
    }
    
    override func didUpdate(to object: Any) {
        if let model = object as? ZZHaoWenTopicListModel {
            topicListModel = model
        }
    }
}
