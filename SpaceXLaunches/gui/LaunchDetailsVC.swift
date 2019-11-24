//
//  LaunchDetailsVC.swift
//  SpaceXLaunches
//
//  Created by Vlad Demenchoock on 19.11.2019.
//  Copyright © 2019 Vlad Demenchoock. All rights reserved.
//

import UIKit
import Kingfisher

class LaunchDetailsVC: UIViewController {

    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var textContainer: UIView!
    @IBOutlet weak var launchImage: UIImageView!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    
    var launchIndex: Int?
    
    @IBOutlet weak var launchYearTitle: UILabel!
    @IBOutlet weak var launchNumberTitle: UILabel!
    @IBOutlet weak var missionNameTitle: UILabel!
    
    @IBOutlet weak var launchYearValue: UILabel!
    @IBOutlet weak var launchNumberValue: UILabel!
    @IBOutlet weak var missionNameValue: UILabel!
    
    @IBOutlet weak var launchDetails: UITextView!
    
    private func configure () {
        guard let index = launchIndex else {return }
        guard let details = LaunchDataService.shared.getLaunchInfo(for: index) else {return }
        
        let url = URL(string: details.links.flickr_images?.first ?? "")
        launchImage.kf.setImage(with: url, placeholder: UIImage(named: "launchPlaceholder"))
        {[weak self] _,_,_,_ in
            self?.imageLoadingIndicator.stopAnimating()
        }
        
        launchDetails.text = details.details
        launchYearValue.text = details.launch_year
        launchNumberValue.text = "\(details.flight_number)"
        missionNameValue.text = details.mission_name
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
        // Do any additional setup after loading the view.
    }
    
    private func setupView () {
        launchYearTitle.text = "Launch Year:"
        launchNumberTitle.text = "Launch Number:"
        missionNameTitle.text = "Mission Name:"
    }

}
