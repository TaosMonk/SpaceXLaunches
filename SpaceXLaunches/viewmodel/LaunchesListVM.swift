//
//  LaunchViewModel.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 25.01.2020.
//  Copyright © 2020 Vlad Demenchoock. All rights reserved.
//

import Foundation

class LaunchesListVM {
    
    var launchesList : [LaunchInfoModel]?
    var dataSource : LaunchDataSource
    var service : LaunchesListDataService
    
    init(dataSource : LaunchDataSource, service: LaunchesListDataService) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func updateLaunchList () {
        
        service.updateLaunchList
            { success in
                guard success else {return } // TODO: handle error, data inaccessable
                self.dataSource.data.value = self.service.launchList!
                self.launchesList = self.service.launchList!
            }
    }
    
    func sortByYear () {
        self.dataSource.data.value = self.launchesList?.sorted(by: {$0.launch_year < $1.launch_year}) ?? []
    }
    
    func sortByNumber () {
        self.dataSource.data.value = self.launchesList?.sorted(by: {$0.flight_number < $1.flight_number}) ?? []
    }
    
    func sortByName () {
        self.dataSource.data.value = self.launchesList?.sorted(by: {$0.mission_name < $1.mission_name}) ?? []
    }
    
    // TODO: those ?? [] are not good, need to think of something else here
}
