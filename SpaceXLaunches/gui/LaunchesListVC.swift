//
//  LaunchesListVC.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 19.11.2019.
//  Copyright © 2019 Vlad Demenchoock. All rights reserved.
//

import UIKit

class LaunchesListVC: UIViewController, UISearchControllerDelegate, UISearchResultsUpdating {
    
    var launchSelectedIndex: Int?
    var launchList: [LaunchInfoModel]?
    var searchController : UISearchController!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        launchTable.delegate = self
        launchTable.dataSource = self
        updateLaunchList()
        setupSearchBar()
    }
    
    @IBOutlet weak var launchTable: UITableView!
    @IBOutlet weak var launchSearchBar: UISearchBar!
    
    private func updateLaunchList () {
        // weak reference to self so that only LaunchDataService.shared.updateLaunchList holds the closure
        // more about this particular structure at https://learnappmaking.com/escaping-closures-swift/
        
        LaunchDataService.shared.updateLaunchList
        { [weak self] (success) in
            guard success else {return } // TODO: handle error, data inaccessable
            self?.launchList = LaunchDataService.shared.launchList
            self?.restoreSorting()
            self?.launchTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let vc = segue.destination as? LaunchDetailsVC else {fatalError()}
        vc.launchIndex = launchSelectedIndex
    }
    
    func setupSearchBar () {
        // for search bar to work correctly, LaunchesListVC must implement protocols UISearchControllerDelegate, UISearchResultsUpdating
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    @IBAction func clickSort(_ sender: Any) {
        // TODO: make it so that it just contains "Soring mode" header
        let alert = UIAlertController(title: "Hello, World", message: "This is my first app!", preferredStyle: .actionSheet)
        
        let sortByYear = UIAlertAction(title: "Sort by launch year", style: .default, handler:
        {_ in
            guard self.sortMode != .byYear else {return }
            self.sortMode = .byYear
            self.sortByYear()
            self.launchTable.reloadData()
        })
        let sortByNumber = UIAlertAction(title: "Sort by flight number", style: .default, handler: {_ in
            guard self.sortMode != .byNumber else {return }
            self.sortMode = .byNumber
            self.sortByNumber()
            self.launchTable.reloadData()
        })
        let sortByName = UIAlertAction(title: "Sort by mission name", style: .default, handler: {_ in
            guard self.self.sortMode != .byName else {return }
            self.sortMode = .byName
            self.sortByName()
            self.launchTable.reloadData()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(sortByYear)
        alert.addAction(sortByNumber)
        alert.addAction(sortByName)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func sortByYear () {
        launchList = launchList?.sorted(by: {$0.launch_year < $1.launch_year})
    }
    
    private func sortByNumber (){
        launchList = launchList?.sorted(by: {$0.flight_number < $1.flight_number})
    }
    
    private func sortByName () {
        launchList = launchList?.sorted(by: {$0.mission_name < $1.mission_name})
    }
    
    func restoreSorting () {
        guard sortMode != .noSort else {return }
        switch sortMode {
            case .byName: sortByName()
            case .byYear: sortByYear()
            case .byNumber: sortByNumber()
            default: break
        }
        
    }
}

extension LaunchesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let info = launchList?[indexPath.row] else {fatalError()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath)
        cell.textLabel?.text = info.mission_name
        cell.detailTextLabel?.text = info.launch_year
        
        let url = URL(string: info.links.mission_patch ?? "")
        cell.imageView?.kf.setImage(with: url, placeholder: UIImage(named: "launchPlaceholder"))
        {[weak self] _,_,_,_ in
            //self?.imageLoadingIndicator.stopAnimating()
        }
        
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        launchSelectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowLaunchDetails", sender: self)
    }
    
}

extension LaunchesListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ launchSearchBar: UISearchBar) {
        launchList = launchList?.filter {$0.mission_name.hasPrefix(launchSearchBar.text!) }
        print("Elements in list: \(launchList?.count ?? 0)")
        self.launchTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        launchList = LaunchDataService.shared.launchList
        self.launchTable.reloadData()
    }
}
