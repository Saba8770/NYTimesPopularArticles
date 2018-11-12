//
//  MockDownloadInteractor.swift
//  NYTimesPopularArticlesTests
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 sample. All rights reserved.
//

import Foundation
import XCTest

@testable import  NYTimesPopularArticles

class MockDownloadInteractor: DownloadImageInteractor {
    let service: MockDownloadService
    
    init(service: MockDownloadService) {
        self.service = service
    }
    
    func startDownload(_ article: Article){
        self.service.startDownload(article)
    }
    func getImage(key: URL) -> UIImage?{
       return nil
    }
    
    func saveDownload(sourceURL: URL, downloadingTo location: URL){
        
    }
    
    func activeDownload(key: URL) -> Download?{
       return self.service.getActiveDownloads()[key]
    }

}
