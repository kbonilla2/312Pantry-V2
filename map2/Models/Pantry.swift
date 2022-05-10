//
//  Pantry.swift
//  map2
//
//  Created by Katharine Bonilla on 12/11/21.
//

import Foundation
import CoreLocation
import UIKit

struct Pantry {
    var title: String
    var subtitle: String
    var description: String?
    var coordinate: CLLocationCoordinate2D
    var color: UIColor
    var imagePath: String?
}
