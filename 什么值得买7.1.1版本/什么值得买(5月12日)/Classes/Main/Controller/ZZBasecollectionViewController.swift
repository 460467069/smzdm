//
//  ZZBasecollectionViewController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/5.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit
import IGListKit

class ZZBasecollectionViewController: ZZFirstBaseViewController {
    lazy var dataSource: [ZZListModel] = {
        let dataSource = [ZZListModel]()
        return dataSource
    }()
    lazy var adapter: ListAdapter = {
        return ListAdapter.init(updater: ListAdapterUpdater(), viewController: self)
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.scrollsToTop = true
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}


extension ZZBasecollectionViewController {
    override func initUI() {
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    func loadData(loadMoreData: Bool) {
        
    }
}

extension ZZBasecollectionViewController: ListAdapterDataSource {
    
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
