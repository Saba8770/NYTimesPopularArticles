//
//  DownloadInteractor.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import  UIKit

protocol DownloadImageInteractor {
    func startDownload(_ article: Article)
    func getImage(key: URL) -> UIImage?
    func saveDownload(sourceURL: URL, downloadingTo location: URL)
    func activeDownload(key: URL) -> Download?
}

class DownloadImageInteractorImpl : DownloadImageInteractor {
    
    private let downloadService: DownloadImageService

    init(downloadService: DownloadImageService) {
        self.downloadService = downloadService
    }
    
    func startDownload(_ article: Article) {
        self.downloadService.startDownload(article)
    }
    
    func getImage(key: URL) -> UIImage? {
         let downloadImageURL = self.downloadPath(for: key)
        return UIImage(contentsOfFile: downloadImageURL.path)
    }
    
    func saveDownload(sourceURL: URL, downloadingTo location: URL) {
        var activeDownloads = self.downloadService.getActiveDownloads()
        let download = activeDownloads[sourceURL]
        activeDownloads[sourceURL] = nil
        
        let destinationURL = self.downloadPath(for: sourceURL)
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            download?.article.isImageDownloaded = true
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
    }
    
    func activeDownload(key: URL) -> Download? {
        return self.downloadService.getActiveDownloads()[key]
    }
    
    private func downloadPath(for url: URL) -> URL {
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
}
