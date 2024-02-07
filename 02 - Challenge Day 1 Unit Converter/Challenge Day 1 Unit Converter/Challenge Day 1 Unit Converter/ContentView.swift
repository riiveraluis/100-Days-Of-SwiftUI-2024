//
//  ContentView.swift
//  Challenge Day 1 Unit Converter
//
//  Created by Luis Rivera Rivera on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    let conversionTypes = ["Temperature", "Length", "Time", "Volume"]
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    let volumeUnits = ["Milliliters", "Liters", "Cups", "Pints", "Gallon"]
    
    @State private var conversionType = "Temperature"
    @State private var sourceUnit = "Celsius"
    @State private var sourceValue = 0.0
    @State private var outputUnit = "Fahrenheit"
    
    @FocusState private var isSourceValueFocused: Bool
    
    var sourceOptions: [String] {
        switch conversionType {
        case "Temperature":
            return temperatureUnits
        case "Length":
            return lengthUnits
        case "Time":
            return timeUnits
        case "Volume":
            return volumeUnits
        default:
            fatalError("Unexpected Conversion Type")
        }
    }
    
    var results: Double {
        let result: Double
        let sourceMeasurement: Measurement<Dimension>
        
        switch sourceUnit {
            // Temperature
        case "Celsius":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitTemperature.celsius)
        case "Fahrenheit":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitTemperature.fahrenheit)
        case "Kelvin":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitTemperature.kelvin)
            
            // Length
        case "Meters":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitLength.meters)
        case "Kilometers":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitLength.kilometers)
        case "Feet":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitLength.feet)
        case "Yards":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitLength.yards)
        case "Miles":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitLength.miles)
            
            // Time
        case "Seconds":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitDuration.seconds)
        case "Minutes":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitDuration.minutes)
        case "Hours":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitDuration.hours)
        case "Days":
            sourceMeasurement = Measurement(value: sourceValue * 24.0, unit: UnitDuration.hours)
            
            // Volume
        case "Milliliters":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitVolume.milliliters)
        case "Liters":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitVolume.liters)
        case "Cups":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitVolume.cups)
        case "Pints":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitVolume.pints)
        case "Gallon":
            sourceMeasurement = Measurement(value: sourceValue, unit: UnitVolume.gallons)
        default:
            fatalError("Unexpected Input Unit")
        }
        
        switch outputUnit {
            // Temperature
        case "Celsius":
            result = sourceMeasurement.converted(to: UnitTemperature.celsius).value
        case "Fahrenheit":
            result = sourceMeasurement.converted(to: UnitTemperature.fahrenheit).value
        case "Kelvin":
            result = sourceMeasurement.converted(to: UnitTemperature.kelvin).value
            
            // Length
        case "Meters":
            result = sourceMeasurement.converted(to: UnitLength.meters).value
        case "Kilometers":
            result = sourceMeasurement.converted(to: UnitLength.kilometers).value
        case "Feet":
            result = sourceMeasurement.converted(to: UnitLength.feet).value
        case "Yards":
            result = sourceMeasurement.converted(to: UnitLength.yards).value
        case "Miles":
            result = sourceMeasurement.converted(to: UnitLength.miles).value
            
            // Time
        case "Seconds":
            result = sourceMeasurement.converted(to: UnitDuration.seconds).value
        case "Minutes":
            result = sourceMeasurement.converted(to: UnitDuration.minutes).value
        case "Hours":
            result = sourceMeasurement.converted(to: UnitDuration.hours).value
        case "Days":
            result = sourceMeasurement.converted(to: UnitDuration.hours).value / 24.0 // To be able to display days
            
            // Volume
        case "Milliliters":
            result = sourceMeasurement.converted(to: UnitVolume.milliliters).value
        case "Liters":
            result = sourceMeasurement.converted(to: UnitVolume.liters).value
        case "Cups":
            result = sourceMeasurement.converted(to: UnitVolume.cups).value
        case "Pints":
            result = sourceMeasurement.converted(to: UnitVolume.pints).value
        case "Gallon":
            result = sourceMeasurement.converted(to: UnitVolume.gallons).value
        default:
            fatalError("Unexpected Output Unit")
        }
        
        return result
    }
    
    var outputUnitSymbol: String {
        let symbol: String
        switch outputUnit {
            // Temperature
        case "Celsius":
            symbol = UnitTemperature.celsius.symbol
        case "Fahrenheit":
            symbol = UnitTemperature.fahrenheit.symbol
        case "Kelvin":
            symbol = UnitTemperature.kelvin.symbol
            
            // Length
        case "Meters":
            symbol = UnitLength.meters.symbol
        case "Kilometers":
            symbol = UnitLength.kilometers.symbol
        case "Feet":
            symbol = UnitLength.feet.symbol
        case "Yards":
            symbol = UnitLength.yards.symbol
        case "Miles":
            symbol = UnitLength.miles.symbol
            
            // Time
        case "Seconds":
            symbol = UnitDuration.seconds.symbol
        case "Minutes":
            symbol = UnitDuration.minutes.symbol
        case "Hours":
            symbol = UnitDuration.hours.symbol
        case "Days":
            symbol = "Days"
            
            // Volume
        case "Milliliters":
            symbol = UnitVolume.milliliters.symbol
        case "Liters":
            symbol = UnitVolume.liters.symbol
        case "Cups":
            symbol = UnitVolume.cups.symbol
        case "Pints":
            symbol = UnitVolume.pints.symbol
        case "Gallon":
            symbol = UnitVolume.gallons.symbol
        default:
            fatalError("Unexpected Symbol Unit")
        }
        
        return symbol
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select conversion type") {
                    Picker("Conversion Type", selection: $conversionType) {
                        ForEach(conversionTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Select source unit") {
                    Picker("Source Unit", selection: $sourceUnit) {
                        ForEach(sourceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Enter \(sourceUnit.lowercased())", value: $sourceValue, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .focused($isSourceValueFocused)
                }
                
                Section("Select output unit") {
                    Picker("Source Unit", selection: $outputUnit) {
                        ForEach(sourceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text("\(results.formatted()) \(outputUnitSymbol)")
                        .bold()
                }
            }
            .onChange(of: conversionType) { resetSegmentedControls() }
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
    
    func resetSegmentedControls() {
        switch conversionType {
        case "Temperature":
            sourceUnit = temperatureUnits[0]
            outputUnit = temperatureUnits[0]
        case "Length":
            sourceUnit = lengthUnits[0]
            outputUnit = lengthUnits[0]
        case "Time":
            sourceUnit = timeUnits[0]
            outputUnit = timeUnits[0]
        case "Volume":
            sourceUnit = volumeUnits[0]
            outputUnit = volumeUnits[0]
        default:
            fatalError("Unexpected Type")
        }
    }
}

#Preview {
    ContentView()
}
