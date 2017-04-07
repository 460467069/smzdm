//
//  ZZPopDimissAnimation.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/17.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZPopDimissAnimation: NSObject {

}


extension ZZPopDimissAnimation: UIViewControllerAnimatedTransitioning{
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.6
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVc = transitionContext.viewController(forKey: .from)
        let toVc = transitionContext.viewController(forKey: .to)
        
        var t1 = CATransform3DIdentity
        t1.m34 = 1.0 / -900.0
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
        t1 = CATransform3DRotate(t1, 20.0 * .pi / 180.0, 1, 0, 0)
        
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            
            fromVc?.view.top = kScreenHeight
            
            toVc?.view.layer.transform = t1
        }) { (finished: Bool) in
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
                
                toVc?.view.layer.transform = CATransform3DIdentity
                toVc?.view.alpha = 1
            }, completion: { (finished: Bool) in
                
                transitionContext.completeTransition(true)
            })
        }

    }
    
}
