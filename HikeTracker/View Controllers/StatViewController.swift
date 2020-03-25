//
//  StatViewController.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 2/28/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class StatViewController: UIViewController {
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var distanceTravelledLabel: UILabel!
    @IBOutlet weak var averagePaceLabel: UILabel!
    @IBOutlet weak var altitudeGainLabel: UILabel!
    @IBOutlet weak var altitudeLossLabel: UILabel!
    @IBOutlet weak var mapTypeControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var saveToolbar: UIToolbar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var timeElapsed = 0
    var distanceTravelled = Measurement(value: 0, unit: UnitLength.meters)
    var polylineCoordinates: [CLLocation] = []
    var altitudeGain = 0
    var altitudeLoss = 0
    var hikeComplete = false
    
    // CoreData formatting
    var hikeName = ""
    var duration = Int16()
    var distance = Double()
    var elevationGain = Int16()
    var elevationLoss = Int16()
    var date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if hikeComplete == true {
            saveToolbar.isHidden = false
        }
        initializeStatsView()
    }
    
    func initializeStatsView() {
        let formattedDistance = FormatDisplay.distance(distanceTravelled)
        let formattedTime = FormatDisplay.time(timeElapsed)
        let formattedPace = FormatDisplay.pace(distance: distanceTravelled, seconds: timeElapsed, outputUnit: UnitSpeed.minutesPerMile)
        
        distance = (formattedDistance as NSString).doubleValue
                
        timeElapsedLabel.text = "\(formattedTime)"
        distanceTravelledLabel.text = "\(formattedDistance)"
        averagePaceLabel.text = "\(formattedPace)"
        altitudeGainLabel.text = "\(altitudeGain)"
        altitudeLossLabel.text = "\(altitudeLoss)"
        
        loadMap()
    }
    
    func loadMap() {
        let region = mapRegion()
        
        mapView.delegate = self
        mapView.setRegion(region!, animated: true)
        renderPolyline()
        renderAnnotations()
    }
    
    func mapRegion() -> MKCoordinateRegion? {
        let latitudes = polylineCoordinates.map { location -> Double in
            return location.coordinate.latitude
        }
        
        let longitudes = polylineCoordinates.map { location -> Double in
            return location.coordinate.longitude
        }
        
        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLon = longitudes.max()!
        let minLon = longitudes.min()!

        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
                                          longitude: (minLon + maxLon) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.5,
                                  longitudeDelta: (maxLon - minLon) * 1.5)
        return MKCoordinateRegion(center: center, span: span)
    }
    
    func renderPolyline() {
        let hikeCoordinates = polylineCoordinates.map { location -> CLLocationCoordinate2D in
            return location.coordinate
        }
        
        let hikePolyline = MKPolyline(coordinates: hikeCoordinates, count: hikeCoordinates.count)
        
        mapView.addOverlay(hikePolyline)
    }
    
    func renderAnnotations() {
        let startLocation = MKPointAnnotation()
        startLocation.title = "Start"
        startLocation.subtitle = "Start"
        startLocation.coordinate = polylineCoordinates.first!.coordinate
        mapView.addAnnotation(startLocation)
        
        let endLocation = MKPointAnnotation()
        endLocation.title = "End"
        endLocation.subtitle = "End"
        endLocation.coordinate = polylineCoordinates.last!.coordinate
        mapView.addAnnotation(endLocation)
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch mapTypeControl.selectedSegmentIndex
        {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        } 
    }
    
    
    @IBAction func saveHike(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Hike Name",
                                      message: "Add a name to remember this hike",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
            [unowned self] action in

            guard let textField = alert.textFields?.first,
            let nameToSave = textField.text else { return }
            self.hikeName = nameToSave
            self.formatData()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    @IBAction func discardHike(_ sender: Any) {
        let alertController = UIAlertController(title: "Are you sure?",
                                                message: "Do you wish to delete this hike?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Delete Hike", style: .destructive) { _ in
                 _ = self.navigationController?.popToRootViewController(animated: true)
        })
               
        present(alertController, animated: true)
    }
    
    func formatData() {
        duration = Int16(timeElapsed)
        elevationGain = Int16(altitudeGain)
        elevationLoss = Int16(altitudeLoss)

        saveHikeData()
    }
    
    func saveHikeData() {
    
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let hikeEntity = NSEntityDescription.entity(forEntityName: "Hike", in: managedContext)!
      
        let hikeData = NSManagedObject(entity: hikeEntity, insertInto: managedContext)
        hikeData.setValue(hikeName, forKey: "name")
        hikeData.setValue(distance, forKey: "distance")
        hikeData.setValue(duration, forKey: "duration")
        hikeData.setValue(elevationGain, forKey: "elevation_gain")
        hikeData.setValue(elevationLoss, forKey: "elevation_loss")
        hikeData.setValue(date, forKey: "timestamp")
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
        
        let locationData = NSManagedObject(entity: locationEntity, insertInto: managedContext)
        
        for location in polylineCoordinates {
            locationData.setValue(location.timestamp, forKey: "timestamp")
            locationData.setValue(location.coordinate.longitude, forKey: "longitude")
            locationData.setValue(location.coordinate.latitude, forKey: "latitude")
            locationData.setValue(NSSet(object: hikeData), forKey: "hikes")
        }

        do {
            try managedContext.save()
            _ = self.navigationController?.popToRootViewController(animated: true)
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}

extension StatViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let lineRenderer = MKPolylineRenderer(polyline: polyline)
        lineRenderer.strokeColor = .systemBlue
        lineRenderer.lineWidth = 4
        return lineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")

        guard let annotationName = annotation.title else {return nil}


        if annotationName == "Start" {
            annotationView.pinTintColor = UIColor.green
        } else if annotationName == "End" {
            annotationView.pinTintColor = UIColor.red
        }
        return annotationView
    }
}


