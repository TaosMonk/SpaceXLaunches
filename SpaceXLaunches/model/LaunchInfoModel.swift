//
//  launchInfoModel.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 23.11.2019.
//  Copyright © 2019 Vlad Demenchoock. All rights reserved.
//

import Foundation

struct LaunchInfoModel {
    let imageLink: String
    let launchDetails: String
    let missionName: String
    let launchYear: String
    let flightNumber: Int
    
    static func getTestData() -> [LaunchInfoModel] {
        
        var _launchesList = [LaunchInfoModel]()
        
        let test1 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "AX2014",
                                    launchYear: "2019",
                                    flightNumber: 95)
        _launchesList.append(test1)
        
        let test2 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "BX1513",
                                    launchYear: "2018",
                                    flightNumber: 93)
        _launchesList.append(test2)
        
        let test3 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "CX1313",
                                    launchYear: "2014",
                                    flightNumber: 16)
        _launchesList.append(test3)
        
        let test4 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "DX3513",
                                    launchYear: "2012",
                                    flightNumber: 24)
        _launchesList.append(test4)
        
        let test5 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "FX3233",
                                    launchYear: "2016",
                                    flightNumber: 36)
        _launchesList.append(test5)
        
        let test6 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "AX2014",
                                    launchYear: "2019",
                                    flightNumber: 95)
        _launchesList.append(test6)
        
        let test7 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "BX1513",
                                    launchYear: "2018",
                                    flightNumber: 93)
        _launchesList.append(test7)
        
        let test8 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "CX1313",
                                    launchYear: "2014",
                                    flightNumber: 16)
        _launchesList.append(test8)
        
        let test9 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "DX3513",
                                    launchYear: "2012",
                                    flightNumber: 24)
        _launchesList.append(test9)
        
        let test10 = LaunchInfoModel(imageLink: "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg",
                                    launchDetails: "none",
                                    missionName: "FX3233",
                                    launchYear: "2016",
                                    flightNumber: 36)
        _launchesList.append(test10)
        
        return _launchesList
    }
}

extension LaunchInfoModel {
    init () {
        imageLink = "https://live.staticflickr.com/65535/46856594755_88f1b22e50_o.jpg"
        launchDetails = "none"
        missionName = "none"
        launchYear = "2019"
        flightNumber = 95
    }
}
