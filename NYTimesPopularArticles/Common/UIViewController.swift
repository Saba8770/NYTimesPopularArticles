//
//  UIViewController.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    class func instantiateFromStoryboard() -> Self {
        return self.instantiateFromStoryboard(self)
    }

    private class func instantiateFromStoryboard<T>(_ type: T.Type) -> T {
        let name = String(describing: self).replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: name+"Storyboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: name) as? T  else {
            fatalError("ViewController could not be instantiated")
        }
        return viewController
    }

}
