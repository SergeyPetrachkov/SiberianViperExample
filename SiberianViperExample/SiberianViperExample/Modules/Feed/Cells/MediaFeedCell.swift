//
//  MediaFeedCell.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 06/05/2018.
//  Copyright © 2018 West Coast IT. All rights reserved.
//

import Foundation
import UIKit
import SiberianVIPER
import Kingfisher

class MediaFeedItemModel: CollectionModelGeneric, SelfSizingModel {
  var calculatedSize: CGSize {
    let attributedTitle = NSAttributedString(string: self.currentModel.title, attributes: [NSAttributedStringKey.font: MediaFeedCellConfigurator.titleFont])
    let titleRect = attributedTitle.boundingRect(with: CGSize(width: MediaFeedCellConfigurator.coverDimension,
                                                              height: CGFloat.greatestFiniteMagnitude),
                                                 options: .usesFontLeading,
                                                 context: nil)
    
    return CGSize(width: 300,
                  height: MediaFeedCellConfigurator.coverDimension + MediaFeedCellConfigurator.coverInsets.bottom + MediaFeedCellConfigurator.coverInsets.top + titleRect.height + MediaFeedCellConfigurator.coverInsets.bottom)
  }
  
  static var anyViewType: UIView.Type {
    return MediaFeedCell.self
  }
  
  let currentModel: FeedItem
  
  init(currentModel: FeedItem) {
    self.currentModel = currentModel
  }
  
  func setup(view: MediaFeedCell) {
    view.viewModel = self
  }
}
fileprivate enum MediaFeedCellConfigurator {
  static let coverInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  static let coverDimension: CGFloat = UIScreen.main.bounds.width - coverInsets.right - coverInsets.left
  static let fontColor: UIColor = .gray
  static let titleFont = UIFont.systemFont(ofSize: 16)
}
class MediaFeedCell: UITableViewCell {
  var viewModel: MediaFeedItemModel? {
    didSet {
      guard let viewModel = self.viewModel else {
        return
      }
      if let url = viewModel.currentModel.mediaInfo?.url {
        self.coverView.kf.setImage(with: URL(string: url))
      }
      self.titleLabel.text = viewModel.currentModel.title
    }
  }
  
  let coverView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .lightGray
    imageView.clipsToBounds = true
    return imageView
  }()
  let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = MediaFeedCellConfigurator.titleFont
    label.textColor = MediaFeedCellConfigurator.fontColor
    return label
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.addSubview(self.coverView)
    self.addSubview(self.titleLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let coverWidth = self.bounds.width - MediaFeedCellConfigurator.coverInsets.left - MediaFeedCellConfigurator.coverInsets.right
    self.coverView.frame = CGRect(x: MediaFeedCellConfigurator.coverInsets.left,
                                  y: MediaFeedCellConfigurator.coverInsets.top,
                                  width: coverWidth, height: coverWidth)
    self.titleLabel.placeDown(after: self.coverView, delta: MediaFeedCellConfigurator.coverInsets.bottom)
    self.titleLabel.frame.origin.x = self.coverView.frame.minX
    self.titleLabel.set(width: coverWidth)
    self.titleLabel.sizeToFit()
//    self.viewModel?.viewSize = CGSize(width: self.bounds.width,
//                                      height: self.titleLabel.frame.maxY + MediaFeedCellConfigurator.coverInsets.bottom)
  }
}
