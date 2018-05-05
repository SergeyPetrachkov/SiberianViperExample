//
//  SVENavigationController.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 05/05/2018.
//  Copyright © 2018 West Coast IT. All rights reserved.
//

import Foundation
import UIKit
import SiberianSwift

class SVENavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.applyNavigationBarTheme(backgroundColor: UIColor.Backgrounds.lightBlue)
    self.navigationBar.isTranslucent = false
    self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
