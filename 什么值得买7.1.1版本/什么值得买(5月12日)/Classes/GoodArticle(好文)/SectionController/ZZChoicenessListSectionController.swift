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
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter.init(updater: ListAdapterUpdater(), viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    var listModel: ZZListModel?
    lazy var dataSource: [ZZListModel] =  {
        let dataSource = [ZZListModel]()
        return dataSource
    }()
    override init() {
        super.init()
        supplementaryViewSource = self
    }
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
        let promotion_type = choicenessModel.promotion_type
        if promotion_type == "6" {
            height = 225
        } else {
            if cellType == "41" {
                height = 200
            } else if cellType == "30" {
                height = 150
            } else if cellType == "38" {
                height = 150
            }
        }
        return CGSize(width: collectionContext!.containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let list = listModel?.subItems as! [ZZChoicenessListModel]
        let choicenessModel = list[index]
        let cellType = choicenessModel.cell_type
        let promotion_type = choicenessModel.promotion_type
        if promotion_type == "6" {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZPromotionType6Cell",
                                                                    bundle: nil,
                                                                    for: self,
                                                                    at: index) as? ZZPromotionType6Cell else {
                                                                        fatalError()
            }
            
            let promotionType6Model = ZZListModel.init(subItems: choicenessModel.yc_rows,
                                                       sectionController: ZZPromotionType6SectionController())
            dataSource.removeAll()
            dataSource.append(promotionType6Model!)
            cell.choicenessModel = choicenessModel
            adapter.collectionView = cell.collectionView
            adapter.performUpdates(animated: false, completion: nil)
            return cell
        } else if promotion_type == "9" {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ZZPromotionType9Cell",
                                                                    bundle: nil,
                                                                    for: self,
                                                                    at: index) as? ZZPromotionType9Cell else {
                                                                        fatalError()
            }
            
            let promotionType6Model = ZZListModel.init(subItems: choicenessModel.yc_rows,
                                                       sectionController: ZZPromotionType6SectionController())
            dataSource.removeAll()
            dataSource.append(promotionType6Model!)
            adapter.collectionView = cell.collectionView
            adapter.performUpdates(animated: false, completion: nil)
            return cell
        }
        
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

extension ZZChoicenessListSectionController: ListSupplementaryViewSource{
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                             for: self,
                                                                             nibName: "ZZTopicHeaderView",
                                                                             bundle: nil,
                                                                             at: index) as? ZZTopicHeaderView else {
                                                                                fatalError()
        }
        view.titleLabel.text = "好文推荐"
        view.moreBtn.isHidden = true
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 60)
    }
}

extension ZZChoicenessListSectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return dataSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let listModel = object as? ZZListModel else { fatalError() }
        return listModel.sectionController
    }
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
