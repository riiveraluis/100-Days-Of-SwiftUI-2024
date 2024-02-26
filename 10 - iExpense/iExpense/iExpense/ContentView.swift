//
//  ContentView.swift
//  iExpense
//
//  Created by Luis Rivera Rivera on 2/25/24.
//

// Challenges

/*
 1. Use the user’s preferred currency, rather than always using US dollars. ExpenseSection File
 2. Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.
 3. For a bigger challenge, try splitting the expenses list into two sections: one for personal expenses, and one for business expenses. This is tricky for a few reasons, not least because it means being careful about how items are deleted!
 */

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ExpenseSection(title: "Personal", expenses: expenses.personalExpenses, deleteItems: removePersonalItems)
                ExpenseSection(title: "Business", expenses: expenses.businessExpenses, deleteItems: removeBusinessItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()

        for offset in offsets {
            let item = inputArray[offset]

            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }

        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        withAnimation {
            removeItems(at: offsets, in: expenses.personalExpenses)
        }
    }

    func removeBusinessItems(at offsets: IndexSet) {
        withAnimation {
            removeItems(at: offsets, in: expenses.businessExpenses)
        }
    }
}

#Preview {
    ContentView()
}
