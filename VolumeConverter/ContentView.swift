//
//  ContentView.swift
//  VolumeConverter
//
//  Created by Alden Luscher on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputVal = 0.0
    @State private var inUnit = "mL"
    @State private var outUnit = "mL"
    let unitList = ["mL", "L", "Cups", "Pints", "Gallons"]
    
    var convert: Double {
        var converted = 0.0
        var mL = 0.0
        for i in unitList {
            if i == "mL" && i == inUnit {
                mL = inputVal
            } else if i == "L" && i == inUnit {
                mL = inputVal*1000
            } else if i == "Cups" && i == inUnit {
                mL = inputVal*236.588
            } else if i == "Pints" && i == inUnit {
                mL = inputVal*473.176
            } else if i == "Gallons" && i == inUnit {
                mL = inputVal*3785.41
            }
        }
        converted = mL
        for i in unitList {
            if i == "L" && i == outUnit {
                converted*=0.001
            } else if i == "Cups" && i == outUnit {
                converted*=0.00422675
            } else if i == "Pints" && i == outUnit {
                converted*=0.00211338
            } else if i == "Gallons" && i == outUnit {
                converted*=0.000264172
            }
        }
        converted = round(converted * 1000) / 1000.0
        return converted
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $inputVal, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Enter Value")
                }
                Section {
                    Picker("Starting Unit", selection: $inUnit) {
                        ForEach(unitList, id: \.self) {
                            Text($0)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Starting Unit")
                }
                Section {
                    Picker("Desired Unit", selection: $outUnit) {
                        ForEach(unitList, id: \.self) {
                            Text($0)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Desired Unit")
                }
                Section {
                    Text(convert, format: .number)
                } header: {
                    Text("Converted Value")
                }
            } .navigationTitle("Volume Convert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
