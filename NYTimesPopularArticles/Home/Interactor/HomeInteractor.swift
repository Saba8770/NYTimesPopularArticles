//
//  HomeInteractor.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

protocol HomeInteractor {
    // Returns in memory articles
    func numberOfArticles() -> Int
    func article(at index: Int) -> Article
    //end
    
    // Fetch articles from server
    func getArticles(completion: @escaping (Bool, String?)-> Void)
    //end
}

class HomeInteractorImpl: HomeInteractor {
    
    private var articles: [Article] = []
    private var network: QueryService
    
    init(network: QueryService) {
        self.network = network
    }
    
    func numberOfArticles() -> Int {
        return articles.count
    }
    
    func article(at index: Int) -> Article {
        return articles[index]
    }
    
    func getArticles(completion: @escaping (Bool, String?) -> Void) {
        self.network.searchPopularArticle(period: "30") { (response, errorMessage) in
            if errorMessage != nil {
                completion(false, errorMessage)
                return
            }
            if let notNilArticle = response {
                self.articles = notNilArticle
                completion(true, nil)
            }
        }
    }
}

