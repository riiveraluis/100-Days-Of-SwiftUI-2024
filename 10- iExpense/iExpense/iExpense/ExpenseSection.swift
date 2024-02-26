//
//  ExpenseSection.swift
//  iExpense
//
//  Created by Luis Rivera Rivera on 2/26/24.
//

import SwiftUI

struct ExpenseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    // Challenge 1
    var systemCurrency: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var body: some View {
        
        Section(title) {
            if !expenses.isEmpty {
                ForEach(expenses) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: systemCurrency)
                            .customTextColor(amount: item.amount)
                    }
                }
                .onDelete(perform: deleteItems)
            } else {
                Text("No expense logged")
            }
        }
    }
}

#Preview {
    ExpenseSection(title: "Section Title", expenses: []) { _ in
        
    }
}
