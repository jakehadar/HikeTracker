//
//  Hike+CoreDataProperties.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 3/5/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//
//

import Foundation
import CoreData


extension Hike {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hike> {
        return NSFetchRequest<Hike>(entityName: "Hike")
    }

    @NSManaged public var distance: Double
    @NSManaged public var duration: Int16
    @NSManaged public var name: String?
    @NSManaged public var elevation_gain: Int16
    @NSManaged public var timestamp: Date?
    @NSManaged public var elevation_loss: Int16
    @NSManaged public var locations: Location?

}
