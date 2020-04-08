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
    
    weak var hike: Hike!
    
    lazy var detailsTableData: Array<Array<String>> = {
        // Scale and format numeric data into display text.
        let durationText = String(format: "%i seconds", hike.duration)
        let distanceText = String(format: "%.2f meters", hike.distance)
        let avgPaceText = String(format: "%.2f m/s", Double(hike.duration) / hike.distance)
        let elevGainText = String(format: "%.2f meters", hike.elevation_gain)
        let elevLossText = String(format: "%.2f meters", hike.elevation_loss)
        
        let data = [
            ["Total Time:", durationText],
            ["Distance Travelled:", distanceText],
            ["Average Pace", avgPaceText],
            ["Total Altitude Gain", elevGainText],
            ["Total Altitude Loss", elevLossText]
        ]
        return data
    }()
    
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailsTableView.dataSource = self
        hikeTitle.text = hike.name
        hikeDate.text = dateFormatter.string(from: hike.timestamp!)
        // TODO: configure annotated map
    }
    
    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
        // TODO: implement
        debugPrint("Delete tapped.")
    }
}

extension PastHikeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableView == detailsTableView else { fatalError() }
        return detailsTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard tableView == detailsTableView else { fatalError() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailListTableViewCell
        cell.title.text = detailsTableData[indexPath.row][0]
        cell.value.text = detailsTableData[indexPath.row][1]
        return cell
    }
}
