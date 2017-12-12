//
//  ZZShareViewController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/16.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import SnapKit


class ZZShareFlowLayout: UICollectionViewFlowLayout {
    let margin: CGFloat = 30
    let columnCount: CGFloat = 3
    let rowCount: CGFloat = 2
    let imageWH: CGFloat = 70
    
    override func prepare() {
        super.prepare()
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, margin, 0, margin)
        minimumInteritemSpacing = ((collectionView?.width)! - margin - margin  - columnCount * imageWH) / (columnCount - 1.0)
        minimumLineSpacing = 0
        
        let itemHeight: CGFloat = (collectionView?.height)! / rowCount
        itemSize = CGSize.init(width: imageWH, height: itemHeight)
        
    }

    
}

class ZZShareViewController: UIViewController {
    
    lazy var dataArray: [ZZShareModel]? = {

        return ZZShareModel.models()
    }()
    
    var shareParams: NSMutableDictionary?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(closBtnDidClick), name: NSNotification.Name(rawValue: "maskBtnDidClick"), object: self)
    }
    
    
    func initUI(){
        
        view.backgroundColor = UIColor.white
        
        let cloesBtn = UIButton()
        
        cloesBtn.frame = CGRect.init(x: 10, y: 10, width: 60, height: 40)
        cloesBtn.setImage(#imageLiteral(resourceName: "ico_close"), for: .normal)
        cloesBtn.setImage(#imageLiteral(resourceName: "ico_close_press"), for: .highlighted)
        view.addSubview(cloesBtn)
        cloesBtn.addTarget(self, action: #selector(closBtnDidClick), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "懂得分享的人最美"
        titleLabel.textColor = UIColor.black
        titleLabel.sizeToFit()
        titleLabel.centerX = kScreenWidth * 0.5
        titleLabel.centerY = cloesBtn.centerY
        view.addSubview(titleLabel)
         
        let collectionView = ZZNoDelayBtnCollectionView.init(frame: CGRect.zero, collectionViewLayout: ZZShareFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(cloesBtn.snp.bottom).offset(10)
            make.bottom.width.equalTo(self.view)
            
        }
        
        collectionView.register(UINib.init(nibName: "ZZShareCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ZZShareCollectionViewCell")
        
        let textField = UITextField()
//        textField.backgroundColor = UIColor.lightGray
        view.addSubview(textField);
        textField.snp.makeConstraints { (make) in
            
            make.right.equalTo(self.view).offset(-10)
            make.size.equalTo(CGSize.init(width: 100, height: 30))
        }
        
    }
    
    
    @objc func closBtnDidClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func share(shareModel: ZZShareModel){
        ShareSDK.share(shareModel.type, parameters: shareParams!) { (state, userData, contentEntity, error) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}

extension ZZShareViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return (ZZShareModel.models()?.count)!
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let shareCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZZShareCollectionViewCell", for: indexPath) as! ZZShareCollectionViewCell
        
        let shareModel = dataArray?[indexPath.item]
        
        shareCell.shareModel = shareModel
        shareCell.delegate = self
        return shareCell
    }
}

extension ZZShareViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
//        (SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error);

        let shareModel = dataArray?[indexPath.item]
        
        
        share(shareModel: shareModel!)
    }
}

extension ZZShareViewController: ZZCellActionDelegate{
    
    func cellDidClick(shareCell: ZZShareCollectionViewCell) {
        let shareModel = shareCell.shareModel
        
        share(shareModel: shareModel!)
    }
    
}
