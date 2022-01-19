//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Okuyama-Smith, Sean (NA) on 14/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sCars = StarterCars()
    @State private var selectedCar: Int = 0
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var anotherPackage = false
    @State private var finalPackage = false
    @State private var remainingFunds = 1000
    @State private var remainingTime = 30
    
    var timerDone: Bool{
        if self.remainingTime == 0{
            return false
        }else{
            return true
        }
    }
    
    var exhaustPackageEnabled: Bool{
        return timerDone ? (exhaustPackage ? true : remainingFunds >= 500 ? true : false) : false
    }
    var tiresPackageEnabled: Bool{
        return timerDone ? (tiresPackage ? true : remainingFunds >= 500 ? true : false) : false
    }
    var anotherPackageEnabled: Bool{
        return timerDone ? (anotherPackage ? true : remainingFunds >= 500 ? true : false) : false
    }
    var finalPackageEnabled: Bool{
        return timerDone ? (finalPackage ? true : remainingFunds == 1000 ? true : false) : false
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: {newValue in
                self.exhaustPackage = newValue
                if newValue{
                    sCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                }else{
                    sCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
            }
        )
        let tiresPackageBinding = Binding<Bool> (
            get: {self.tiresPackage},
            set: {newValue in
                self.tiresPackage = newValue
                if newValue{
                    sCars.cars[selectedCar].handling += 3
                    remainingFunds -= 500
                }else{
                    sCars.cars[selectedCar].handling -= 3
                    remainingFunds += 500
                }
            }
        )
        let anotherPackageBinding = Binding<Bool> (
            get: {self.anotherPackage},
            set: {newValue in
                self.anotherPackage = newValue
                if newValue{
                    sCars.cars[selectedCar].acceleration -= 2.0
                    remainingFunds -= 500
                }else{
                    sCars.cars[selectedCar].acceleration += 2.0
                    remainingFunds += 500
                }
            }
        )
        let finalPackageBinding = Binding<Bool> (
            get: {self.finalPackage},
            set: {newValue in
                self.finalPackage = newValue
                if newValue{
                    sCars.cars[selectedCar].topSpeed += 15
                    remainingFunds -= 1000
                }else{
                    sCars.cars[selectedCar].topSpeed -= 15
                    remainingFunds += 1000
                }
            }
        )
        Form{
            VStack{
                Text("\(remainingTime)")
                    .onReceive(timer, perform: { _ in
                        if self.remainingTime > 0{
                            self.remainingTime -= 1
                        }
                    })
                    .foregroundColor(.red)
                Text(sCars.cars[selectedCar].displayStats())
                    .padding()
                Button(action: {
                    selectedCar += 1
                    if selectedCar == sCars.cars.count{
                        selectedCar = 0
                    }
                }, label: {
                    Text("Next Car")
                })
                .disabled(!timerDone)
            }
            Section{
                Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                    .disabled(!exhaustPackageEnabled)
                Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                    .disabled(!tiresPackageEnabled)
                Toggle("Another Package (Cost: 500)", isOn: anotherPackageBinding)
                    .disabled(!anotherPackageEnabled)
                Toggle("Final Package (Cost: 1000)", isOn: finalPackageBinding)
                    .disabled(!finalPackageEnabled)
                Text("Remaining Funds: \(remainingFunds)")
                    .foregroundColor(.red)
                    .baselineOffset(20.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
