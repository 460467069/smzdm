//
//  ZZCommentModel.swift
//  什么值得买
//
//  Created by HM on 16/11/6.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZCommentModel: NSObject {

    var comment_date: String?

    var floor: String?

    var oppose_count: String?

    var medals: [ZZMedal]?
    
    var parent_data: [ZZCommentModel]?

    var comment_author: String?

    var user_id: String?

    var is_anonymous: String?

    var format_date_client: String?

    var official: String?

    var from_client: String?

    var comment_ID: String?

    var format_date: String?

    var level: String?

    var level_logo: String?

    var support_count: String?

    var has_christmas_hat: Bool = false

    var head: String?

    var have_current_user: String?

    var from_client_version: String?

    var comment_content: String?

    var from_client_uri: String?

    var ding_class: String?

    var comment_parent_ids: String?

    var post_author: String?

    var comment_parent: String?

    var from_client_suff: String?

    var user_smzdm_id: String?
    
    
    class func modelContainerPropertyGenericClass()->[String : AnyObject]{
        return ["parent_data" : ZZCommentModel.self,
                "medals" : ZZMedal.self]
    }
    
}

class ZZMedal: NSObject {

    var img: String?

    var desc: String?

}



