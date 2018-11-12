//
//  MockDownloadService.swift
//  NYTimesPopularArticlesTests
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 sample. All rights reserved.
//

import Foundation
import XCTest
@testable import NYTimesPopularArticles

class MockDownloadService: DownloadImageService{
    private var activeDownloads: [URL: Download] = [:]
    
    func startDownload(_ article: Article){
        let download = Download(article: article)
        download.isDownloading = true
        activeDownloads[article.aritcleImageURL!] = download
    }
    func getActiveDownloads() -> [URL: Download]{
        return activeDownloads
    }
}
