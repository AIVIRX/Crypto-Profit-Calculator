//
//  CurrencyTextField.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 9/27/24.
//

import SwiftUI

struct CurrencyTextField: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    var placeholder: String
    @Binding var text: String
    var selectedCurrency: String
    var body: some View {
        VStack{
            HStack{
                Text(selectedCurrency)
                    .foregroundStyle(.primary)
                    .font(.system(size: inputFontSize, weight: .black, design: .rounded))
                ZStack(alignment: .leading) {
                    TextField(placeholder, text: $text)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .padding(.horizontal, 8)
                        .font(.system(size: inputFontSize, weight: .black, design: .rounded))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.plain)
                        .onChange(of: text) { _, newValue in
                            text = validateInput(newValue)
                        }
                }
            }
            .font(.headline)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .dark ? .black : .white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(colorScheme == .dark ? 0.4 : 0.25), lineWidth: 1)
                    )
            )
            .padding(8)
        }
    }

    private var inputFontSize: CGFloat {
        horizontalSizeClass == .regular ? 32 : 40
    }
    
    private func validateInput(_ input: String) -> String {
        // Get the user's locale decimal separator
        let locale = Locale.current
        let decimalSeparator = locale.decimalSeparator ?? "."
        let groupingSeparator = locale.groupingSeparator ?? ","
        
        // Allow only numbers and the user's decimal separator
        let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: decimalSeparator))
        
        // Filter the input to only allow valid characters
        let filtered = input.filter { char in
            allowedCharacters.contains(char.unicodeScalars.first!) || 
            (groupingSeparator.count == 1 && char == groupingSeparator.first!)
        }
        
        // Ensure only one decimal separator
        let components = filtered.components(separatedBy: decimalSeparator)
        if components.count > 2 {
            return components[0] + decimalSeparator + components[1]
        }
        
        return filtered
    }
}
