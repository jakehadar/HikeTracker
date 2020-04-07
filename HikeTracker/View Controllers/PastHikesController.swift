//
//  PastHikesController.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 3/5/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//

import UIKit
import CoreData

class PastHikesViewController: UIViewController {
    
    @IBOutlet weak var hikeTableView: UITableView!
    
    var hikeArray = [Hike]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
      
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let fetchedHikes = try managedContext.fetch(Hike.fetchRequest())
            for fetchedHike in fetchedHikes {
                hikeArray.append(fetchedHike as! Hike)
            }
        } catch {
            print("Failed")
        }
        
        // Clear last selection
        if let indexPath = hikeTableView.indexPathForSelectedRow {
            hikeTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PastHikeDetailViewController
        let indexPath = hikeTableView.indexPathForSelectedRow!
        let hike = hikeArray[indexPath.row]
        vc.hike = hike
    }
}


extension PastHikesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hikeArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let hike = hikeArray[indexPath.row]
        let hikeDate = hike.value(forKey: "timestamp")
        let cell = tableView.dequeueReusableCell(withIdentifier: "HikeCell", for: indexPath)
        cell.textLabel?.text = "\(hike.value(forKey: "name") ?? "Error")"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: hikeDate as! Date))"
        return cell
    }
}








