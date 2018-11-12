//
//  Download.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

class Download {
    var article: Article
    var task: URLSessionDownloadTask?
    var isDownloading = false
    
    init(article: Article) {
        self.article = article
    }
}
