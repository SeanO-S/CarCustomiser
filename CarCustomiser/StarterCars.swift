//
//  StarterCars.swift
//  CarCustomiser
//
//  Created by Okuyama-Smith, Sean (NA) on 17/01/2022.
//

import Foundation

struct StarterCars {
    let modelsAndMakes: [String:[String]] = [
        "Porsche":["911", "Cayenne", "718"],
        "Audi":["TT", "A4", "A3"],
        "BMW":["3 Series", "X5", "X3"]
    ]
    var cars: [Car]
    init() {
        cars = []
        for (key, value) in modelsAndMakes{
            for element in value{
                cars.append(Car(model: element, make: key, acceleration: Float.random(in: 2..<10), topSpeed: Int.random(in: 100..<200), handling: Int.random(in: 0..<10)))
            }
        }
    
    }
}
