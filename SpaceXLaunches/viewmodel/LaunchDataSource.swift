//
//  GenericDataSource.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 25.01.2020.
//  Copyright © 2020 Vlad Demenchoock. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class LaunchDataSource : GenericDataSource<LaunchInfoModel>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // guard let info = data.value?[indexPath.row] else {fatalError()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath)
        cell.textLabel?.text = data.value[indexPath.row].mission_name
        cell.detailTextLabel?.text = data.value[indexPath.row].launch_year
        
        return cell
    }
}
