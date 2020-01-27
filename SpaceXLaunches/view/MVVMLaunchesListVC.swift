//
//  LaunchesListVC.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 25.01.2020.
//  Copyright © 2020 Vlad Demenchoock. All rights reserved.
//

import Foundation
import UIKit

class MVVMLaunchesListViewController: UIViewController {
    
    @IBOutlet weak var launchTable : UITableView!
    
    enum SortMode: Int {
        case noSort, byYear, byName, byNumber
    }
    
    private var sortMode: SortMode
    {
        get {
            return SortMode(rawValue: UserDefaults.standard.integer(forKey: "LaunchesSortMode")) ?? .noSort
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "LaunchesSortMode")
        }
    }
    
    lazy var viewModel : LaunchesListVM = {
        let viewModel = LaunchesListVM(dataSource: LaunchDataSource(), service: LaunchesListDataService())
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List of launches"
        
        self.launchTable.dataSource = self.viewModel.dataSource
        self.viewModel.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.launchTable.reloadData()
        }
        
        self.viewModel.updateLaunchList()
    }
    
    
    @IBAction func clickSort(_ sender: Any) {
        // TODO: make it so that it just contains "Soring mode" header
        let alert = UIAlertController(title: "Hello, World", message: "This is my first app!", preferredStyle: .actionSheet)
        
        let sortByYear = UIAlertAction(title: "Sort by launch year", style: .default, handler:
        {_ in
            guard self.sortMode != .byYear else {return }
            self.sortMode = .byYear
            self.viewModel.sortByYear()
        })
        let sortByNumber = UIAlertAction(title: "Sort by flight number", style: .default, handler: {_ in
            guard self.sortMode != .byNumber else {return }
            self.sortMode = .byNumber
            self.viewModel.sortByNumber()
        })
        let sortByName = UIAlertAction(title: "Sort by mission name", style: .default, handler: {_ in
            guard self.self.sortMode != .byName else {return }
            self.sortMode = .byName
            self.viewModel.sortByName()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(sortByYear)
        alert.addAction(sortByNumber)
        alert.addAction(sortByName)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
}
