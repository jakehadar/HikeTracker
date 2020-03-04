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
    @IBOutlet weak var netAltitudeLabel: UILabel!
    
    var timeElapsed = 0
    var distanceTravelled = Measurement(value: 0, unit: UnitLength.meters)
    var polylineCoordinates: [CLLocation] = []
    var elevationChange = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeStatsView()
    }
    
    func initializeStatsView() {
        let formattedDistance = FormatDisplay.distance(distanceTravelled)
        let formattedTime = FormatDisplay.time(timeElapsed)
        let formattedPace = FormatDisplay.pace(distance: distanceTravelled, seconds: timeElapsed, outputUnit: UnitSpeed.minutesPerMile)
                
        timeElapsedLabel.text = "\(formattedTime)"
        distanceTravelledLabel.text = "\(formattedDistance)"
        averagePaceLabel.text = "\(formattedPace)"
        netAltitudeLabel.text = "\(elevationChange)"
        
        loadMap()
    }
    
    func loadMap() {
        
    }
}
