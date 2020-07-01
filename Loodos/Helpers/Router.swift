//
//  Router.swift
//  Beezerve
//
//  Created by İsmail Hacıcaferoğlu on 22.03.2020.
//  Copyright © 2020 ismailcaferoglu. All rights reserved.
//

import Alamofire
import SwiftyJSON

public enum Router:URLRequestConvertible {
    
    case getSearchResult(params:Parameters)
    case getMovieDetails(params:Parameters)
    
    enum Constants {
        static let baseURLPath = "http://www.omdbapi.com/"
    }
    
    
    var method:HTTPMethod {
        switch self {
        case .getSearchResult:
            return .get
        case .getMovieDetails:
            return .get
        }
        
    }
    
//    var header:HTTPHeaders {
//        switch self {
//        default:
//            return ["Authorization":Constants.authenticationToken]
//        }
//    }
    
    var parameters:Parameters {
        switch self {
        case .getSearchResult(let params):
            return params
        case .getMovieDetails(let params):
            return params
        }
    }
    
    var path:String {
        switch self {
        case .getSearchResult:
            return ""
        case .getMovieDetails:
            return ""
        }
    }
    
    
    public func asURLRequest() throws -> URLRequest {
 
        let url = try Constants.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(300)
        
        switch self {
        case .getSearchResult:
            return try URLEncoding.default.encode(request, with: parameters)
        case .getMovieDetails:
            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
}
