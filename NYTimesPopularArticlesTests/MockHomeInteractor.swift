//
//  MockHomeInteractor.swift
//  NYTimesPopularArticlesTests
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 sample. All rights reserved.
//

import Foundation
import XCTest

@testable import  NYTimesPopularArticles

class MockHomeInteractor: HomeInteractor {
    let service: MockQueryService
    
    init(service:MockQueryService){
        self.service = service
    }
    
    func numberOfArticles() -> Int{
        return 10
    }
    func article(at index: Int) -> Article{
        let article = Article(id: 1002345,
                              title: "Newyork times test news",
                              author: "BY A. Arthor & BB. Dash",
                              publishedDate: "12-08-08",
                              aritcleImageURL: URL(string:"https://static01.nyt.com/images/2018/11/06/us/elections/results-senate-forecast-static/results-senate-forecast-static-sfSpan.jpg"))
        return article
    }
    
    func getArticles(completion: @escaping (Bool, String?)-> Void){
        self.service.searchPopularArticle(period: "30") { (response, errorMessage) in
            if errorMessage != nil {
                completion(false, errorMessage)
                return
            }
            completion(true,nil)
        }
    }
}
