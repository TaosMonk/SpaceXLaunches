//
//  LaunchesListVC.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 19.11.2019.
//  Copyright © 2019 Vlad Demenchoock. All rights reserved.
//

import UIKit

class LaunchesListVC: UIViewController {
    
    var launchSelectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        LaunchTable.delegate = self
        LaunchTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var LaunchTable: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let vc = segue.destination as? LaunchDetailsVC else {fatalError()}
        vc.centerLabel.text = "Selected row: \(launchSelectedIndex)"
    }

}

extension LaunchesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath)
        cell.textLabel?.text = "123"
        cell.detailTextLabel?.text = "Detail"
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        launchSelectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowLaunchDetails", sender: self)
    }
    
}
