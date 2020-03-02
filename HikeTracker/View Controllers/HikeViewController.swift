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
    
    
    private let locationManager = CLLocationManager()
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startHike(_ sender: UIBarButtonItem) {
        checkLocationServices()
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManger()
            checkLocationAuthorization()
        } else {
            // instruct user to turn oon
        }
    }
    
    func setUpLocationManger() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            initializeHikeTracking()
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func initializeHikeTracking() {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        mapView.removeOverlays(mapView.overlays)
        seconds = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
          self.incrementSeconds()
        }
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateCurrentStats()
    }
    
    func incrementSeconds() {
        seconds += 1
        updateCurrentStats()
    }
    
    func updateCurrentStats() {
        let formattedTime = time(seconds)
        timeLabel.text = "Time:  \(formattedTime)"
        
     }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
 
}

extension HikeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // display user elevation
        let altitude = location.altitude
        altitudeLabel.text = "Altitude: \(Int(altitude))"
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
    
    
    
    // formatting for hike stats
    func time(_ seconds: Int) -> String {
        let formattedTime = DateComponentsFormatter()
        formattedTime.allowedUnits = [.hour, .minute, .second]
        formattedTime.unitsStyle = .positional
        formattedTime.zeroFormattingBehavior = .pad
        return formattedTime.string(from: TimeInterval(seconds))!
    }
}










