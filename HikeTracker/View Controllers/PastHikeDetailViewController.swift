//
//  PastHikeDetailViewController.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 3/5/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//

import UIKit
import MapKit

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
    
    var selectedRow = 0
//    let selectedHikeArray = [NSArray] = []
    var pastHikeTitle = ""
    var pastHikeDate = ""
    var pastHikeDuration = 0
    var pastHikeDistance = 0.0
    var pastHikeAltGain = 0
    var pastHikeAltLoss = 0
    var pastHikeCoordinates: [CLLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
