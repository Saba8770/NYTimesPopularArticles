//
//  HomePresenter.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter {
    let view: HomeViewAdaptor?
    let wireframe: HomeWireframe
    let interactor: HomeInteractor
    let downloadInteractor: DownloadImageInteractor
    
    init(view: HomeViewController?,
         wireframe: HomeWireframe,
         interactor: HomeInteractor,
         downloadInteractor: DownloadImageInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
        self.downloadInteractor = downloadInteractor
    }
    
    func viewWillAppear() {
        self.interactor.getArticles { (success, errorMessage) in
            if let _ = errorMessage {
                return
            }
            self.view?.reloadArticles()
        }
    }
    func numberOfArticles() -> Int {
        return self.interactor.numberOfArticles()
    }
    
    func article(at index: Int) -> Article {
        return self.interactor.article(at: index)
    }
    
    func download(article: Article) {
        self.downloadInteractor.startDownload(article)
    }
    
    func getImage(key: URL) -> UIImage? {
        return self.downloadInteractor.getImage(key: key)
    }
    
    func saveDownload(sourceURL: URL, downloadingTo location: URL) {
        self.downloadInteractor.saveDownload(sourceURL: sourceURL, downloadingTo: location)
    }
    
    func activeDownload(key: URL) -> Download? {
        return self.downloadInteractor.activeDownload(key: key)
    }
}

