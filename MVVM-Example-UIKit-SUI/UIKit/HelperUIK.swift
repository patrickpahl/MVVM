//
//  HelperUIK.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 4/4/23.
//

import Foundation

struct CellModel {
    let carMakeText: String
    let carModelText: String
    let price: Int
    
    var formattedPriceText: String {
        let currencyText = Currency.numberToCurrency(number: price)
        return "$\(currencyText)"
    }
    
    var cellText: String {
        return "\(carMakeText) \(carModelText), Price: \(formattedPriceText)"
    }
}

class Currency {
    
    static func numberToCurrency(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: number as NSNumber) ?? ""
    }
    
}
