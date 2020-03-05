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
    
    var hikeArray: [NSManagedObject] = []
    

    @IBOutlet var labelTest: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
      
        let managedContext = appDelegate.persistentContainer.viewContext
      
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Hike")
      
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                hikeArray.append(data)
            }
        } catch {
            print("Failed")
        }
        loadData()
    }
    
    func loadData() {
        print("\(hikeArray)")
         labelTest.text = "\(hikeArray[3].value(forKey: "duration") as! Int16)"
    }
}




