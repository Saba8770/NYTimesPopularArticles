//
//  Wireframe.swift
//  NYTimesPopularArticles
//
//  Created by Saba Ahmad on 11/12/18..
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit

class Wireframe: NSObject {
    private(set) var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}
