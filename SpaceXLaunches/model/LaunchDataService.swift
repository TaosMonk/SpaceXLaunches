//
//  LaunchDataService.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 23.11.2019.
//  Copyright © 2019 Vlad Demenchoock. All rights reserved.
//

import Foundation

class LaunchDataService {
    var launchesNumber: Int {
        return _launchesList?.count ?? 0
    }
    
    var launchList: [LaunchInfoModel] {
        prepareTestData()
        return _launchesList!
    }
    
    func getLaunchInfo (for index: Int) -> LaunchInfoModel {
        //TODO: test, replace with real model
        return LaunchInfoModel()
    }
    
    private func prepareTestData () {
        guard _launchesList == nil else {return }
        _launchesList = LaunchInfoModel.getTestData()
    }
// MARK: - PROPERTIES
    
    private var _launchesList: [LaunchInfoModel]?
    
// MARK: - PERSISTENCE
    
    static var shared: LaunchDataService {
        if _instance != nil {
            return _instance!
        } else {
            _instance = LaunchDataService()
            return _instance!
        }
    }
    
    private static var _instance: LaunchDataService?
    
    private init () {
        
    }
}
