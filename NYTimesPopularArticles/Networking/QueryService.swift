//
//  QueryService.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

private var kApiKey = "a9edf20f94464a769435abb55e0d9319" //Enter_Api_Key"
typealias QueryResult = ([Article]?, String?) -> Void

protocol QueryService {
    func cancelPreviousSearch()
    func searchPopularArticle(period: String, completion: @escaping QueryResult)
}

// Runs query data task, and stores results in array of photos
class QueryServiceImpl: QueryService {

    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private var errorMessage: String?
    
    
    func cancelPreviousSearch() {
        dataTask?.cancel()
    }
    
    func searchPopularArticle(period: String, completion: @escaping QueryResult) {
        if var urlComponents = URLComponents(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/\(period).json") {
            urlComponents.query = "apikey=\(kApiKey)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage = "DataTask error: " + error.localizedDescription + "\n"
                    completion(nil, self.errorMessage)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 ||  response.statusCode == 202 {
                    self.updateSearchResults(data, completion: completion)
                }
            }
            dataTask?.resume()
        }
    }
    
    fileprivate func updateSearchResults(_ data: Data, completion: @escaping QueryResult) {
        typealias JSONDictionary = [String: Any]
        var response: JSONDictionary?
        var articles: [Article] = []

        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage = "JSONSerialization error: \(parseError.localizedDescription)\n"
            completion(nil, errorMessage)
            return
        }
        
        guard let notNilDic = response,
            let popularArticles = notNilDic["results"] as? [Any] else {
            errorMessage = "Dictionary does not contain results key\n"
            completion(nil, errorMessage)
            return
        }
        
        for articleInfo in popularArticles {
            if let articleParam = articleInfo as? JSONDictionary,
                let id = articleParam["id"] as? Int,
                let title = articleParam["title"] as? String, !title.isEmpty,
                let author = articleParam["byline"] as? String,
                let publishedDate = articleParam["published_date"] as? String {
                var imagrURL: URL?
                // Retrive article url
                if let metadata = articleParam["media"] as? [JSONDictionary],
                    let mediaMetadata = metadata.first as JSONDictionary?,
                    let imageMetadataInfo = mediaMetadata["media-metadata"] as? [JSONDictionary],
                    let imageMetadata = imageMetadataInfo.first as JSONDictionary?,
                    let url = imageMetadata["url"] as? String {
                    imagrURL = URL(string: url)
                }
                let article = Article(id: id,
                                      title: title,
                                      author: author,
                                      publishedDate: publishedDate,
                                      aritcleImageURL: imagrURL)
                articles.append(article)
            }
        }
        completion(articles, errorMessage)
    }
    
}
