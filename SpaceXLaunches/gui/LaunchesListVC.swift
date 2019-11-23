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

    override func viewDidLoad() {
        super.viewDidLoad()
        launchTable.delegate = self
        launchTable.dataSource = self
        launchList = LaunchDataService.shared.launchList
        setupSearchBar()
    }
    
    @IBOutlet weak var launchTable: UITableView!
    @IBOutlet weak var launchSearchBar: UISearchBar!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let vc = segue.destination as? LaunchDetailsVC else {fatalError()}
        vc.launchIndex = launchSelectedIndex
    }
    
    func setupSearchBar () {
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
        let alert = UIAlertController(title: "Hello, World", message: "This is my first app!", preferredStyle: .actionSheet)
        
        let sortByYear = UIAlertAction(title: "Sort by launch year", style: .default, handler:
        {_ in
            self.sortByYear()
            self.launchTable.reloadData()
        })
        let sortByNumber = UIAlertAction(title: "Sort by flight number", style: .default, handler: {_ in
            self.sortByNumber()
            self.launchTable.reloadData()
        })
        let sortByName = UIAlertAction(title: "Sort by mission name", style: .default, handler: {_ in
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
        launchList = launchList?.sorted(by: {$0.launchYear < $1.launchYear})
    }
    
    private func sortByNumber (){
        launchList = launchList?.sorted(by: {$0.flightNumber < $1.flightNumber})
    }
    
    private func sortByName () {
        launchList = launchList?.sorted(by: {$0.missionName < $1.missionName})
    }
}

extension LaunchesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let info = launchList?[indexPath.row] else {fatalError()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath)
        cell.textLabel?.text = info.missionName
        cell.detailTextLabel?.text = info.launchDetails
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        launchSelectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowLaunchDetails", sender: self)
    }
    
}

extension LaunchesListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ launchSearchBar: UISearchBar) {
        launchList = launchList?.filter {$0.missionName.hasPrefix(launchSearchBar.text!) }
        print("Elements in list: \(launchList?.count)")
        self.launchTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        launchList = LaunchDataService.shared.launchList
        self.launchTable.reloadData()
    }
}
