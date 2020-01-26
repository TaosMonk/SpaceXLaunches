//
//  LaunchDataService.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 23.11.2019.
//  Copyright © 2019 Vlad Demenchoock. All rights reserved.
//

import Foundation
import Alamofire

class LaunchDataService {
    var launchesNumber: Int {
        return _launchesList?.count ?? 0
    }
    
    var launchList: [LaunchInfoModel]? {
        //prepareTestData()
        return _launchesList
    }
    
    func getLaunchInfo (for index: Int) -> LaunchInfoModel? {
        //TODO: test, replace with real model
        guard let list = _launchesList, list.count > index
        else {return nil}
        return list[index]
    }
    
//    private func prepareTestData () {
//        guard _launchesList == nil else {return }
//        _launchesList = LaunchInfoModel.getTestData()
//    }
    
    func updateLaunchList (completion: @escaping (Bool) -> Void)
    {
        //responseJSON requires a completion handler closure with @escaping which can be called after responseJSON has been run
        Alamofire.request(LaunchDataService.serviceURL).responseJSON
        { response in
            guard response.error == nil
            else
            {
                print(response.error!)
                completion(false)
                return
            }
            guard let data = response.data else {print("No Data");return}
            do
            {
                // try to use JSONDecoder to fill _launchesList with LaunchInfoModel structs
                // example of how this works in documentation
                self._launchesList = try JSONDecoder().decode([LaunchInfoModel].self, from: data)
                print(self._launchesList ?? "Empty list")
                completion(true)
            }
            catch
            {
                print(error)
                completion(false)
            }
        }
    }
    
// MARK: - PROPERTIES
    
    private var _launchesList: [LaunchInfoModel]?
    private static let serviceURL: String = "https://api.spacexdata.com/v3/launches"
    
// MARK: - PERSISTENCE
// example of singleton - holds the only object of class LaunchDataService to handle updateLaunchList calls
    
    static var shared: LaunchDataService {
        if _instance != nil {
            return _instance!
        } else {
            _instance = LaunchDataService()
            return _instance!
        }
    }
    
    private static var _instance: LaunchDataService?
    
    //there is nothing to initialize in this class, and we privatized the init() so that nobody can create LaunchDataService from the outside - only shared can be used
    private init () {
        
    }
}
