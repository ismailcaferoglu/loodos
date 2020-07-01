//
//  SearchResult.swift
//  Loodos
//
//  Created by İsmail Caferoğlu on 28.06.2020.
//  Copyright © 2020 İsmail Caferoğlu. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    
    var title:String
    var year:String
    var runtime:String
    var director:String
    var actors:String
    var plot:String
    var imdbRating:String
    
    init(json:JSON) {
        
        self.title = json["Title"].stringValue
        self.year = json["Year"].stringValue
        self.runtime = json["Runtime"].stringValue
        self.director = json["Director"].stringValue
        self.actors = json["Actors"].stringValue
        self.plot = json["Plot"].stringValue
        self.imdbRating = json["imdbRating"].stringValue
        
    }
}
