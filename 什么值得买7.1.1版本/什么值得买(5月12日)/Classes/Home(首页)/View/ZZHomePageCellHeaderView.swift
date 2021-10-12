//
//  ZZHomePageCellHeaderView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/26.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit
import YYText

@objcMembers class ZZHomePageCellHeaderView: UIView {
    @IBOutlet weak var tagLabel: YYLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelfNameXibOnSelf()
    }
    
    var worthyArticle: ZZWorthyArticle? {
        didSet {
            guard let article = worthyArticle else {
                return
            }
            let text = NSMutableAttributedString()
            configureTagLabelAttributedString(tag: article.article_first_channel_name, text: text, isFirst: true)
            configureTagLabelAttributedString(tag: article.article_second_channel_name, text: text, isFirst: false)
            configureTagLabelAttributedString(tag: article.article_third_channel_name, text: text, isFirst: false)
            
            tagLabel.attributedText = text
            
            let modifier = YYTextLinePositionSimpleModifier()
            modifier.fixedLineHeight = 12
            tagLabel.linePositionModifier = modifier
        }
    }
    
    func configureTagLabelAttributedString(tag: String?, text: NSMutableAttributedString, isFirst: Bool) {
        guard let tagStr = tag else { return }
        if tagStr.count == 0 {
            return
        }
        if isFirst {
            
        }
        
        let one = NSMutableAttributedString.init(string: tagStr)
        one.yy_insertString("  ", at: 0)
        one.yy_appendString("  ")

        if isFirst {
            one.yy_font = UIFont.systemFont(ofSize: 12)
            one.yy_color = UIColor.zz_color(withRed: 170, green: 170, blue: 170)
        } else {
            one.yy_font = UIFont.systemFont(ofSize: 12)
            one.yy_color = UIColor.zz_color(withRed: 170, green: 170, blue: 170)
            let border = YYTextBorder()
            border.strokeWidth = 0.5
            border.strokeColor = one.yy_color
            border.insets = UIEdgeInsets(top: -1.5, left: -3, bottom: -1.5, right: -3)
            border.cornerRadius = 2.0
            let oneStr = one.string as NSString
            one.yy_setTextBackgroundBorder(border, range: oneStr.range(of: tagStr))
        }
        text.append(one)
    }
}
