//
//  PlaceDetails.swift
//  placesTest
//
//  Created by André Alves on 22/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit

class PlaceDetails: Decodable {
    var id: Int
    var name: String
    var review: Double
    var type: String
    var about: String
    var phone: String
    var adress: String
    var schedule: Schedule
}
