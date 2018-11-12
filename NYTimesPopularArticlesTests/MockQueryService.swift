//
//  MockQueryService.swift
//  NYTimesPopularArticlesTests
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 sample. All rights reserved.
//

import Foundation
import XCTest
@testable import NYTimesPopularArticles


class MockQueryService: QueryService {
    
    init(){
    }
    
    func cancelPreviousSearch(){
        
    }
    
    func searchPopularArticle(period: String, completion: @escaping QueryResult) {
        completion(nil, "Something went wrong")
    }
}
