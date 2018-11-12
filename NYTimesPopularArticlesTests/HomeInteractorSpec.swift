//
//  HomeInteractorSpec.swift
//  NYTimesPopularArticlesTests
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 sample. All rights reserved.
//

import Foundation
import XCTest
@testable import NYTimesPopularArticles

class HomeInteractorSpec: XCTestCase {
    
    
    var queryInteractor: MockHomeInteractor!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let queryService = MockQueryService()
        queryInteractor =  MockHomeInteractor(service: queryService)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        queryInteractor = nil
    }
    
    /*
     Spec negative case
     */
    func testSearchArticle() {
        var isSuccess = true
        let expectation = self.expectation(description: "NY Articles")
        self.queryInteractor.getArticles{ (success, errorMessage) in
            isSuccess = success
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertFalse(isSuccess)
    }

    /*
     Spec the article and its properties
     */
    func testArticle() {
        let article = self.queryInteractor.article(at: 0)
        XCTAssertNotNil(article)
        XCTAssertNotNil(article.title)
        XCTAssertNotNil(article.author)
        XCTAssertNotNil(article.publishedDate)
        XCTAssertNotNil(article.aritcleImageURL)
    }
}

