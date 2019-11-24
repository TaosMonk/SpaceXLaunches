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
        Alamofire.request("https://api.spacexdata.com/v3/launches").responseJSON
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
                self._launchesList = try JSONDecoder().decode([LaunchInfoModel].self, from: data)
                print(self._launchesList)
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
