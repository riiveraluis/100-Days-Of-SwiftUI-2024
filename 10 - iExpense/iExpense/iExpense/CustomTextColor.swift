//
//  CustomTextColor.swift
//  iExpense
//
//  Created by Luis Rivera Rivera on 2/26/24.
//

import Foundation
import SwiftUI

struct CustomTextColor: ViewModifier {
    let amount: Double
    func body(content: Content) -> some View {
        var color: Color
        switch amount {
        case ...10.0:
            color = .green
        case ...100.0:
            color = .orange
        case 100.0...:
            color = .red
        default:
            color = .primary
        }
        
      return content.foregroundStyle(color)
    }
}

extension View {
    func customTextColor(amount: Double) -> some View {
        self.modifier(CustomTextColor(amount: amount))
    }
}
