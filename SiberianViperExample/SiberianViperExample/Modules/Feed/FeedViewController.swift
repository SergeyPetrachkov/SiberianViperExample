//
//  FeedViewController.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 05/05/2018.
//  Copyright (c) 2018 West Coast IT. All rights reserved.
//
//  This file was generated by the SergeyPetrachkov VIPER Xcode Templates so
//  you can apply VIPER architecture to your iOS projects
//

import UIKit
import SiberianVIPER

class FeedViewController: UITableViewController {
  // MARK: - UI properties
  
  // MARK: - Essentials
  var presenter: FeedPresenterInput?

  lazy var displayManager: SiberianCollectionManager? = { [weak self] in
    guard let strongSelf = self,
      let provider = strongSelf.presenter as? AnySiberianCollectionSource else {
        return nil
    }
    let manager = SiberianCollectionManager(provider: provider,
                                            delegate: strongSelf.presenter as? SiberianCollectionDelegate,
                                            fetchDelegate: nil)
    
    
    return manager
  }()

  // MARK: - Setup
  fileprivate func setup() {
    self.tableView.dataSource = self.displayManager
    self.tableView.delegate = self.displayManager
    self.refreshControl = UIRefreshControl()
    self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
    self.refreshControl?.tintColor = UIColor.darkGray
    self.tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
    self.tableView.tableFooterView = UIView()
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
    self.presenter?.start()
  }

  // MARK: - Actions
  @objc fileprivate func handleRefresh(_ refreshControl: UIRefreshControl) {
    self.presenter?.refresh()
  }
}
extension FeedViewController: FeedPresenterOutput {
  func didEnterPendingState(visible: Bool, blocking: Bool) {
    self.tableView.isUserInteractionEnabled = !blocking
    if visible {
      self.refreshControl?.beginRefreshing()
    }
  }
  
  func didExitPendingState() {
    self.tableView.isUserInteractionEnabled = true
    self.refreshControl?.endRefreshing()
  }
  func didChangeState(viewModel : Feed.DataContext.ViewModel) {
    if viewModel.changeSet.count == 0 {
      self.presenter?.exitPendingState()
      return
    }
    var newIndexPaths = [IndexPath]()
    var editedIndexPaths = [IndexPath]()
    var deletedIndexPaths = [IndexPath]()
    var shouldScrollToTop = false
    viewModel.changeSet.forEach({ change in
      switch change {
      case .new(let indexPath):
        if let indexPath = indexPath {
          newIndexPaths.append(indexPath)
        }
      case .edit(let indexPath):
        editedIndexPaths.append(indexPath)
      case .delete(let indexPath):
        deletedIndexPaths.append(indexPath)
      }
    })
    if deletedIndexPaths.count > 0 {
      shouldScrollToTop = true
    }
    if #available(iOS 11.0, *) {
      self.tableView.performBatchUpdates({
        if deletedIndexPaths.count > 0 {
          self.tableView.deleteRows(at: deletedIndexPaths, with: .automatic)
        }
        if newIndexPaths.count > 0 {
          self.tableView.insertRows(at: newIndexPaths, with: .automatic)
        }
        if editedIndexPaths.count > 0 {
          self.tableView.reloadRows(at: editedIndexPaths, with: .automatic)
        }
      }, completion: { result in
        print("Feed batch update ended with result: \(result) \n\rtotal: \(viewModel.items.count) \n\rnew:\(newIndexPaths.count) \n\rchanged: \(editedIndexPaths.count) \n\rdeleted: \(deletedIndexPaths.count)")
        if shouldScrollToTop, self.tableView.contentOffset.y > 120 {
          self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        self.presenter?.exitPendingState()
      })
    } else {
      self.tableView.beginUpdates()
      if deletedIndexPaths.count > 0 {
        self.tableView.deleteRows(at: deletedIndexPaths, with: .automatic)
      }
      if newIndexPaths.count > 0 {
        self.tableView.insertRows(at: newIndexPaths, with: .automatic)
      }
      if editedIndexPaths.count > 0 {
        self.tableView.reloadRows(at: editedIndexPaths, with: .automatic)
      }
      self.presenter?.exitPendingState()
      print("-OLD- : Feed batch update ended. \n\rtotal: \(viewModel.items.count) new:\(newIndexPaths.count) changed: \(editedIndexPaths.count) deleted: \(deletedIndexPaths.count)")
      self.tableView.endUpdates()
      return
    }
  }
}
