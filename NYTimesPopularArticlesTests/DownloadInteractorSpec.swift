//
//  DownloadInteractorSpec.swift
//  NYTimesPopularArticlesTests
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 sample. All rights reserved.
//

import Foundation
import XCTest
@testable import NYTimesPopularArticles

class DownloadInteractorSpec: XCTestCase {
    
    var downloadInteractor: MockDownloadInteractor!
    var article: Article!
    
    override func setUp() {
        super.setUp()
        let mockDownloadService = MockDownloadService()
        downloadInteractor = MockDownloadInteractor(service: mockDownloadService)
        article = Article(id: 1002345,
                          title: "Newyork times test news",
                          author: "BY A. Arthor & BB. Dash",
                          publishedDate: "12-08-08",
                          aritcleImageURL: URL(string:"https://static01.nyt.com/images/2018/11/06/us/elections/results-senate-forecast-static/results-senate-forecast-static-sfSpan.jpg"))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        downloadInteractor = nil
        article = nil
    }
    /*
     Spec the negative case
     */
    func testCachedImage() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let image = self.downloadInteractor.getImage(key: URL(string: "https://static01.nyt.com/images/2018/11/06/us/elections/results-senate-forecast-static/results-senate-forecast-static-sfSpan.jpg")!)
        // Expecting Nil
        XCTAssertNil(image)
    }
    /*
     Spec the download process
     */
    
    func testActiveDownload() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        self.downloadInteractor.startDownload(self.article)
        let activeDownload = self.downloadInteractor.activeDownload(key: self.article.aritcleImageURL!)
        // Expecting NotNil
        XCTAssertNotNil(activeDownload?.article)
        // Download should begin
        XCTAssertTrue(activeDownload!.isDownloading)
    }
}
