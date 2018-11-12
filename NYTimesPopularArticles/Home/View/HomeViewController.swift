//
//  HomeViewController.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var articlesTable: UITableView!
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articlesTable.separatorStyle = .singleLine
        self.articlesTable.tableFooterView = UIView()
        let navBarColor = UIColor(displayP3Red: 245.0/255.0, green: 201/255.0, blue: 171/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = navBarColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.title = "Popular Article"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let titleLabel = cell.viewWithTag(111) as? UILabel
        let autorLabel = cell.viewWithTag(112) as? UILabel
        let publishDate = cell.viewWithTag(113) as? UILabel
        let articleImage = cell.viewWithTag(110) as? UIImageView

        let article = self.presenter.article(at: indexPath.row)
        titleLabel?.text = article.title
        autorLabel?.text = article.author
        publishDate?.text = article.publishedDate
        if let imagrURL = article.aritcleImageURL,
            let savedImage = self.presenter.getImage(key: imagrURL) {
            articleImage?.image = savedImage
        } else {
            self.presenter.download(article: article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension HomeViewController: HomeViewAdaptor {
    
    func reloadArticles() {
        DispatchQueue.main.async {
            self.articlesTable.reloadData()
        }
    }
}
