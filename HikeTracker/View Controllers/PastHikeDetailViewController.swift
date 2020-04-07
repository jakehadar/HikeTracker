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
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var deleteHikeButton: UIToolbar!
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    weak var hike: NSManagedObject?
    
    lazy var hikeDetails: Array<Array<String>> = {
        guard let hike = hike else { fatalError() }
        let duration = hike.value(forKey: "duration") as! Double
        let distance = hike.value(forKey: "distance") as! Double
        let averPace = distance / duration
        let elevGain = hike.value(forKey: "elevation_gain") as! Int
        let elevLoss = hike.value(forKey: "elevation_loss") as! Int
        let data = [
            ["Total Time:", "\(duration)"],
            ["Distance Travelled:", "\(distance)"],
            ["Average Pace", "\(averPace)"],
            ["Total Altitude Gain", "\(elevGain)"],
            ["Total Altitude Loss", "\(elevLoss)"]
        ]
        return data
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailsTableView.dataSource = self
        
        if let hike = hike {
            hikeTitle.text = "\(hike.value(forKey: "name") as! String)"
            hikeDate.text = dateFormatter.string(from: hike.value(forKey: "timestamp") as! Date)
            // TODO: configure vc.mapView
        }
    }
}

extension PastHikeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableView == detailsTableView else { fatalError() }
        return hikeDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard tableView == detailsTableView else { fatalError() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailListTableViewCell
        cell.title.text = hikeDetails[indexPath.row][0]
        cell.value.text = hikeDetails[indexPath.row][1]
        return cell
    }
}
