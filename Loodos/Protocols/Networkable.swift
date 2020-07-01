//
//  Networkable.swift
//  Beezerve
//
//  Created by İsmail Hacıcaferoğlu on 22.03.2020.
//  Copyright © 2020 ismailcaferoglu. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol Networkable {
    
    func getSearchResult(parameters:Parameters,completionHandler:@escaping([SearchResult]?, Error?)->Void)
    func getMovieDetail(parameters:Parameters,completionHandler:@escaping(Movie?, Error?)->Void)
    
}

extension Networkable {
    
    func getSearchResult(parameters:Parameters,completionHandler:@escaping([SearchResult]?,Error?)->Void){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            
            AF.request(Router.getSearchResult(params: parameters)).validate().responseJSON(completionHandler: { response  in
                
                switch response.result {
                case let .success(value):
                    
                    var movieArray = [SearchResult]()
                    let json:JSON = JSON(value)
                    let jsonData = json["Search"].arrayValue
                    jsonData.forEach({ movie in
                        let object = SearchResult(json: movie)
                        movieArray.append(object)
                    })
                    
                    DispatchQueue.main.async {
                        completionHandler(movieArray,nil)
                    }
                    
                case .failure(let err):
                    
                    completionHandler(nil,err)
                }
                
            })
        }
    }
    
    func getMovieDetail(parameters:Parameters,completionHandler:@escaping(Movie?,Error?)->Void){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            
            AF.request(Router.getSearchResult(params: parameters)).validate().responseJSON(completionHandler: { response  in
                
                switch response.result {
                case let .success(value):
                    
                    let json:JSON = JSON(value)
                    let object = Movie(json: json)
                    
                    DispatchQueue.main.async {
                        completionHandler(object,nil)
                    }
                    
                case .failure(let err):
                    
                    completionHandler(nil,err)
                }
                
            })
        }
    }
    
}
