//
//  StatViewController.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 2/28/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class StatViewController: UIViewController {
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var distanceTravelledLabel: UILabel!
    @IBOutlet weak var averagePaceLabel: UILabel!
    @IBOutlet weak var elevationGainedLabel: UILabel!
    @IBOutlet weak var elevationLostLabel: UILabel!
    
    
    var hike: Hike!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeStatsView()
    }

    func initializeStatsView() {
        let distance = Measurement(value: hike.distance, unit: UnitLength.meters)
        let seconds = Int(hike.duration)
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance,
                                                 seconds: seconds,
                                                 outputUnit: UnitSpeed.minutesPerMile)

        timeElapsedLabel.text = "\(formattedTime)"
        distanceTravelledLabel.text = "\(formattedDistance)"
        averagePaceLabel.text = "\(formattedPace)"

//        mapView.
    }
    
//    private func loadMap() {
//        guard
//        let locations = hike.locations,
//        locations.count > 0,
//        let region = mapRegion()
//        else {
//            let alert = UIAlertController(title: "Error",
//                                         message: "Sorry, this hike has no locations saved",
//                                         preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//            present(alert, animated: true)
//            return
//        }
//
//        mapView.setRegion(region, animated: true)
//        mapView.addOverlays(polyline())
//    }
}
