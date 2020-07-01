//
//  SearchResult.swift
//  Loodos
//
//  Created by İsmail Caferoğlu on 28.06.2020.
//  Copyright © 2020 İsmail Caferoğlu. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SearchResult {
    
    var title:String
    var year:String
    var imdbID:String
    var poster:String
    
    init(json:JSON) {
        
        self.title = json["Title"].stringValue
        self.year = json["Year"].stringValue
        self.imdbID = json["imdbID"].stringValue
        self.poster = json["Poster"].stringValue
        
    }
}
