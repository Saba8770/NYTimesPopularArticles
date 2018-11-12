//
//  HomeViewController+URLSessionDelegates.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//


import Foundation
import UIKit

extension HomeViewController: URLSessionDownloadDelegate {

    // Save downloaded file
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url else { return }
        self.presenter.saveDownload(sourceURL: sourceURL, downloadingTo: location)
        if let download = self.presenter.activeDownload(key: sourceURL),
            let index = download.article.index {
            DispatchQueue.main.async {
                if  self.presenter.numberOfArticles() >= index {
                    self.articlesTable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
        }
    }
}
