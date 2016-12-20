//
//  ZZPOPPresentAnimation.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/17.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZPopPresentAnimation: NSObject {

}


extension ZZPopPresentAnimation: UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toVc = transitionContext.viewController(forKey: .to)
        let fromVc = transitionContext.viewController(forKey: .from)
        
        toVc?.view.top = kScreenHeight
        toVc?.view.height = 280
        toVc?.view.width = kScreenWidth
        

        let maskBtn = UIButton()
        maskBtn.backgroundColor = UIColor.clear
        maskBtn.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: kScreenWidth, height: kScreenHeight))
        transitionContext.containerView.addSubview(maskBtn)
        maskBtn.addTarget(self, action: #selector(maskBtnDidClick), for: .touchUpInside)
        
        transitionContext.containerView.addSubview((toVc?.view)!)
        
        print(transitionContext.containerView)
        
        var t1 = CATransform3DIdentity
        t1.m34 = 1.0 / -900.0;
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
        t1 = CATransform3DRotate(t1, 20.0 * CGFloat(M_PI) / 180.0, 1.0, 0, 0)
        
        var t2 = CATransform3DIdentity
        t2.m34 = 1.0 / -900.0
        t2 = CATransform3DScale(t2, 0.95, 0.95, 1)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            
            fromVc?.view.layer.transform = t1
            
        }) { (finished: Bool) in
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
                
                fromVc?.view.alpha = 0.5
                fromVc?.view.layer.transform = t2
                
                toVc?.view.bottom = kScreenHeight
                
            }, completion: { (finished: Bool) in
                
                transitionContext.completeTransition(true)
            })
        }
        
        
    }
    
    func maskBtnDidClick(){
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "maskBtnDidClick"), object: self)
    }
    
    
}
