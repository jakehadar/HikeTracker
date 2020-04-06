//
//  PastHikeDetailViewController.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 3/5/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PastHikeDetailViewController: UIViewController {
    
    @IBOutlet weak var hikeTitle: UILabel!
    @IBOutlet weak var hikeDate: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var averagePace: UILabel! 
    @IBOutlet weak var totalAltitudeGained: UILabel!
    @IBOutlet weak var totalAltitudeLost: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var deleteHikeButton: UIToolbar!
    
    let dateFormatter = DateFormatter()
    
    var hike: NSManagedObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let hike = hike {
            hikeTitle.text = "\(hike.value(forKey: "name") as! String)"
            hikeDate.text = dateFormatter.string(from: hike.value(forKey: "timestamp") as! Date)
            totalTime.text = "\(hike.value(forKey: "duration") as! Int)"
            totalDistance.text = "\(hike.value(forKey: "distance") as! Double)"
            averagePace.text = ""  // TODO: math
            totalAltitudeGained.text = "\(hike.value(forKey: "elevation_gain") as! Int)"
            totalAltitudeLost.text = "\(hike.value(forKey: "elevation_loss") as! Int)"
            // TODO: configure vc.mapView
        }
    }
}
