//
//  AddView.swift
//  iExpense
//
//  Created by Luis Rivera Rivera on 2/25/24.
//

import SwiftUI

struct AddView: View {
    @Environment (\.dismiss) var dissmis
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Personal", "Business"]
    
    var expenses: Expenses
    
    var systemCurrency: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: systemCurrency)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.insert(item, at: 0)
                    dissmis()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
