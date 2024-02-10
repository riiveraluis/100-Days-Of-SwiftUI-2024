//
//  ContentView.swift
//  WeSplit
//
//  Created by Luis Rivera Rivera on 2/3/24.
//

// Challenges:
/*
 1. Add a header to the third section, saying “Amount per person”
 2. Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
 3. Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.
 4. Use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.
 */
import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipAmount = 20
    @FocusState private var amountIsFocused:Bool
    
    //    let tipPercentages = [10, 15, 20, 25, 0]
    
    var checkTotal: Double {
        let tipSelection = Double(tipAmount)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipAmount)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var localCurrency: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check amount", value: $checkAmount, format: .currency(code: localCurrency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                // Challenge 3
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipAmount) {
                        ForEach(0..<101, id: \.self) {
                                Text("\($0)%")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                // Challenge 2 and 4
                Section("Total Amount") {
                    Text(checkTotal, format: .currency(code: localCurrency))
                        .foregroundStyle(tipAmount == 0 ? .red : .primary)
                }
                
                // Challenge 1
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: localCurrency))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
