//
//  ViewModel.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/21/23.
//

import Foundation

public protocol ViewModel: ObservableObject {
    associatedtype ActionDelegate
    associatedtype Action

    var actionDelegate: ActionDelegate? { get set }

    func send(_ action: Action)
}
