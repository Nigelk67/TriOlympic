//
//  Swim.swift
//  TriOlympic
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI


struct SwimPost {
    let duration: Int16
    let timestamp: Date
    let distance: Double
    
    init(duration: Int16, timestamp: Date, distance: Double) {
        self.timestamp = timestamp
        self.duration = duration
        self.distance = distance
    }
}
