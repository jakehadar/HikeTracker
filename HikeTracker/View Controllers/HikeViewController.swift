//
//  HikeViewController.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 2/28/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class HikeViewController: UIViewController {
  
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var startButton: UIBarButtonItem!
    @IBOutlet weak var statsButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    
    private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    var locationList: [CLLocation] = []
    
    
//    var hike: Hike?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func startHike(_ sender: UIBarButtonItem) {
        locationList.removeAll()
        mapView.removeOverlays(mapView.overlays)
        initializeHikeTracking()
    }
    
    @IBAction func stopHike(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Are you sure?",
                                                message: "Do you wish to end your hike?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in self.stopHike()
//            self.saveHike()
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
          self.stopHike()
          _ = self.navigationController?.popToRootViewController(animated: true)
        })
        
        present(alertController, animated: true)
    }
    
    func initializeHikeTracking() {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsCompass = true
        
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        updateCurrentStats()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
          self.incrementSeconds()
        }
        initializeLocationManager()
    }
    
    func incrementSeconds() {
        seconds += 1
        updateCurrentStats()
    }
    
    func initializeLocationManager() {
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        locationManager.activityType = .fitness
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func updateCurrentStats() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        //AveragePace
        //let formattedPace = FormatDisplay.pace(distance: distance, seconds: seconds,             outputUnit: UnitSpeed.minutesPerMile)
        //        paceLabel.text = "Pace:  \(formattedPace)"
        distanceLabel.text = "Distance:  \(formattedDistance)"
        timeLabel.text = "Time:  \(formattedTime)"
     }
    
    func stopHike() {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        locationManager.stopUpdatingLocation()
    }

//    func saveHike() {
//        let newHike = Hike(context: CoreDataStack.context)
//        newHike.distance = distance.value
//        newHike.duration = Int16(seconds)
//        newHike.timestamp = Date()
//
//        for location in locationList {
//            let locationObject = Location(context: CoreDataStack.context)
//            locationObject.timestamp = location.timestamp
//            locationObject.latitude = location.coordinate.latitude
//            locationObject.longitude = location.coordinate.longitude
//            newHike.addToLocations(locationObject)
//        }
//
//        CoreDataStack.saveContext()
//
//        hike = Hike
//    }

}

extension HikeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:   [CLLocation]) {
        for newLocation in locations {
            guard newLocation.horizontalAccuracy < 20 && abs(newLocation.timestamp.timeIntervalSinceNow) < 10 else { continue }
        
            if let lastLocation = locationList.last {
                
                //Current altitude
                let elevation = lastLocation.altitude.rounded()
                altitudeLabel.text = ("Altitude: \(Int(elevation)) m")
                
                //Current speed (miles per minute)
                var speed: CLLocationSpeed = CLLocationSpeed()
                speed = 26.8224 / locationManager.location!.speed
                paceLabel.text = String(format: "Pace: %.2f min/mi", speed)
                
                //Create polyline segment
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                mapView.addOverlay(MKPolyline(coordinates: coordinates, count: 2))
            }
            
        locationList.append(newLocation)
        }
    }
}

extension HikeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderedLine = MKPolylineRenderer(polyline: polyline)
        renderedLine.strokeColor = .systemBlue
        renderedLine.lineWidth = 3
        return renderedLine
    }
}












