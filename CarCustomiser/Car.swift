//
//  Car.swift
//  CarCustomiser
//
//  Created by Okuyama-Smith, Sean (NA) on 14/01/2022.
//

import Foundation


struct Car{
    var model: String
    var make: String
    var acceleration: Float
    var topSpeed: Int
    var handling: Int
    
    func displayStats() -> String{
        return "Car Make: \(self.make) \nCar Model: \(self.model)\nTop Speed: \(self.topSpeed)\nAcceleration: \(self.acceleration)\nHandling: \(self.handling)"
    }
}

