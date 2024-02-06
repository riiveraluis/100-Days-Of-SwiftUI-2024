//
//  ContentView.swift
//  Challenge Day 1 Unit Converter
//
//  Created by Luis Rivera Rivera on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    @State private var sourceUnit = "Celsius"
    @State private var sourceValue = 0.0
    @FocusState private var isSourceValueFocused: Bool
    @State private var outputUnit = "Fahrenheit"
    
    var results: Double {
        let result: Double
        let sourceMeasurement: Measurement<UnitTemperature>
        
        switch sourceUnit {
        case "Celsius":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitTemperature.celsius)
        case "Fahrenheit":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitTemperature.fahrenheit)
        case "Kelvin":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitTemperature.kelvin)
        default:
            fatalError("Unexpected Input Unit")
        }
        
        switch outputUnit {
        case "Celsius":
            result = sourceMeasurement.converted(to: UnitTemperature.celsius).value
        case "Fahrenheit":
            result = sourceMeasurement.converted(to: UnitTemperature.fahrenheit).value
        case "Kelvin":
            result = sourceMeasurement.converted(to: UnitTemperature.kelvin).value
        default:
            fatalError("Unexpected Output Unit")
        }
        
        return result
    }
    
    var outputUnitSymbol: String {
        let symbol: String
        switch outputUnit {
        case "Celsius":
            symbol = UnitTemperature.celsius.symbol
        case "Fahrenheit":
            symbol = UnitTemperature.fahrenheit.symbol
        case "Kelvin":
            symbol = UnitTemperature.kelvin.symbol
        default:
            fatalError("Unexpected Output Unit")
        }
        
        return symbol
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Select source unit") {
                    Picker("Source Unit", selection: $sourceUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Enter \(sourceUnit) value", value: $sourceValue, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .focused($isSourceValueFocused)
                }
                
                Section("Select output unit") {
                    Picker("Source Unit", selection: $outputUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text("\(results.formatted())\(outputUnitSymbol)")
                        .bold()
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if isSourceValueFocused {
                    Button("Done") {
                        isSourceValueFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
