//
//  UserDm.swift
//  SwiftUiMvvm
//
//  Created by Singularity - Jewel Rana on 15/11/22.
//

import Foundation

struct UserDm: Codable, Identifiable{
    var id: Int
    var login: String?
    var avatar_url: String?
    var node_id: String?
    
    
    init(id: Int, login: String?, avatar_url: String?,node_id: String?) {
        self.id = id
        self.login = login
        self.avatar_url = avatar_url
        self.node_id = node_id
    }
}
