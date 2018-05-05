//
//  FeedHeaderView.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 05/05/2018.
//  Copyright © 2018 West Coast IT. All rights reserved.
//

import Foundation
import UIKit
import SiberianVIPER


struct FeedHeaderModel: CollectionModelGeneric {
  static var anyViewType: UIView.Type {
    return FeedHeaderView.self
  }
  let currentModel: Account
  func setup(view: FeedHeaderView) {
    view.avatarImageView.setImage(string: self.currentModel.username, color: UIColor.Backgrounds.lightBlue)
    view.usernameLabel.attributedText = NSMutableAttributedString(string: self.currentModel.username,
                                                                  alignment: .center,
                                                                  font: UIFont.systemFont(ofSize: 14),
                                                                  lineBreakMode: .byWordWrapping,
                                                                  lineSpacing: 0,
                                                                  foregroundColor: .black,
                                                                  backgroundColor: .white)
    
    view.companyLabel.attributedText = NSMutableAttributedString(string: self.currentModel.description,
                                                                 alignment: .center,
                                                                 font: UIFont.systemFont(ofSize: 13,
                                                                                         weight: .light),
                                                                 lineBreakMode: .byWordWrapping,
                                                                 lineSpacing: 0,
                                                                 foregroundColor: .gray,
                                                                 backgroundColor: .white)
    view.setNeedsLayout()
  }
}
class FeedHeaderView: UIView {
  fileprivate enum Configurator {
    static let avatarDimension: CGFloat = UIDevice.current.isSmallScreen ? 60 : 80
    static let avatarSize: CGSize = CGSize(width: avatarDimension, height: avatarDimension)
    static let avatarTopOffset: CGFloat = UIDevice.current.isSmallScreen ? 16 : 24
  }
  let avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.frame.size = Configurator.avatarSize
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = Configurator.avatarDimension / 2
    return imageView
  }()
  
  let usernameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()
  
  let companyLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(self.avatarImageView)
    self.addSubview(self.usernameLabel)
    self.addSubview(self.companyLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.avatarImageView.center.x = self.center.x
    self.avatarImageView.frame.origin.y = Configurator.avatarTopOffset
    self.usernameLabel.sizeToFit()
    self.usernameLabel.placeDown(after: self.avatarImageView, delta: 40)
    self.companyLabel.sizeToFit()
    self.companyLabel.placeDown(after: self.usernameLabel, delta: 8)
    self.usernameLabel.center.x = self.center.x
    self.companyLabel.center.x = self.center.x
  }
}
