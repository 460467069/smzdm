//
//  UIKit+Rx.swift
//  什么值得买
//
//  Created by Wang_Ruzhou on 2018/7/21.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIView {
    public var rx_hidden: AnyObserver<Bool> {
        return AnyObserver { [weak self] event in
            MainScheduler.ensureExecutingOnScheduler()
            switch event {
            case .next(let value):
                self?.isHidden = value
            case .error(let error):
                bindingErrorToInterface(error)
            case .completed:
                break
            }
        }
    }
}

extension UITextField {
    var rx_returnKey: Observable<Void> {
        return self.rx.controlEvent(.editingDidEndOnExit).takeUntil(rx.deallocated)
    }
}
