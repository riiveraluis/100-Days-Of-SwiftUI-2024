//
//  ContentView.swift
//  BetterRest
//
//  Created by Luis Rivera Rivera on 2/15/24.
//

// Challenges
/*
 1. Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
 2. Replace the “Number of cups” stepper with a Picker showing the same range of values.
 3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
 */

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var recommendedBedtime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return Date.now.formatted(date: .omitted, time: .shortened)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Challenge 1
                Section("When do you want to wake up?") {
                    //                    VStack(alignment: .leading, spacing: 0) {
                    //                        Text("When do you want to wake up?")
                    //                            .font(.headline)
                    DatePicker("Please enter a wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    //                    }
                }
                
                Section("Desired amount of sleep") {
                    //                    VStack(alignment: .leading,  spacing: 0) {
                    //                        Text("Desired amount of sleep")
                    //                            .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    //                    }
                }
                
                Section("Daily coffee intake") {
                    //                    VStack(alignment: .leading, spacing: 0) {
                    //                        Text("Daily coffee intake")
                    //                            .font(.headline)
                    //                        Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    // Challenge 2
                    Picker("Coffee Intake", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                    //                    }
                }
                
                // Challenge 3
                Section {
                    VStack(alignment: .center) {
                        Text(recommendedBedtime)
                            .font(.title3.bold())
                    }
                } header: {
                    Text("Suggested Bedtime")
                        .font(.subheadline)
                        .foregroundStyle(.purple)
                }
            }
            .navigationTitle("BetterRest")
            //            .toolbar {
            //                Button("Calculate", action: calculateBedtime)
            //            }
            //            .alert(alertTitle, isPresented: $isShowingAlert) {
            //                Button("Ok"){}
            //            } message: {
            //                Text(alertMessage)
            //            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        isShowingAlert = true
    }
}

#Preview {
    ContentView()
}
