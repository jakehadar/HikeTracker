//
//  StatViewController.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 2/28/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//

import UIKit
import CoreLocation

class StatViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var distanceTravelledLabel: UILabel!
    @IBOutlet weak var averagePaceLabel: UILabel!
    @IBOutlet weak var elevationGainedLabel: UILabel!
    @IBOutlet weak var elevationLostLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initializeStatsView()
    }
    
//    func initializeStatsView() {
//        let distance = Measurement(value: run.distance, unit: UnitLength.meters)
//        let seconds = Int(run.duration)
//        let formattedDistance = FormatDisplay.distance(distance)
//        let formattedDate = FormatDisplay.date(run.timestamp)
//        let formattedTime = FormatDisplay.time(seconds)
//        let formattedPace = FormatDisplay.pace(distance: distance,
//                                                 seconds: seconds,
//                                                 outputUnit: UnitSpeed.minutesPerMile)
//
//        distanceLabel.text = "Distance:  \(formattedDistance)"
//        dateLabel.text = formattedDate
//        timeLabel.text = "Time:  \(formattedTime)"
//        paceLabel.text = "Pace:  \(formattedPace)"
//
//        loadMap()
//    }
}
