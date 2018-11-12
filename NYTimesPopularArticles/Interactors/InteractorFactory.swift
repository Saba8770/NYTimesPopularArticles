//
//  InteractorFactory.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

class InteractorFactory {
    static let sharedInstance = InteractorFactory()
    
    func queryService() -> QueryService {
        return QueryServiceImpl()
    }

    func homeScreenInteractor() -> HomeInteractor {
        return HomeInteractorImpl(network: self.queryService())
    }

  func downloadService(delegate: URLSessionDelegate) -> DownloadImageService {
      return DownloadImageServiceImpl(delegate: delegate)
  }

 func downloadInteractor(delegate: URLSessionDelegate) -> DownloadImageInteractor {
     let service = self.downloadService(delegate: delegate)
     return DownloadImageInteractorImpl(downloadService: service)
 }
}
