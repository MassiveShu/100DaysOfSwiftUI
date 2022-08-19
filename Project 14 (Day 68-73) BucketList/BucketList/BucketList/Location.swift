//
//  Location.swift
//  BucketList
//
//  Created by Max Shu on 17.08.2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitide: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitide, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "example name", description: "example description", latitide: 51.501, longitude: -0.141)
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
