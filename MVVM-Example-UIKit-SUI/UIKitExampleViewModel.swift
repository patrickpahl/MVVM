//
//  UIKitExampleViewModel.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/20/23.
//

import Foundation
import Combine

struct CellModel {
    let carMakeText: String
    let carModelText: String
}

class UIKitExampleViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case loaded
        case error
    }
    
    enum Action {
        case cellTapped(indexPath: IndexPath)
        case firstButtonTapped
        case secondButtonTapped
    }
    
    @Published var state: State = .initial
    var cellModels: [CellModel] = []
    
    init() {}
    
    func loadData() {
        state = .loading
        cellModels = createMockData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.state = .loaded
        }
    }
    
    private func createMockData() -> [CellModel] {
        let porsche = CellModel(carMakeText: "Porsche", carModelText: "911")
        let honda = CellModel(carMakeText: "Honda", carModelText: "Accord")
        let volkswagen = CellModel(carMakeText: "Volkswagen", carModelText: "GTI")
        let subaru = CellModel(carMakeText: "Subaru", carModelText: "WRX")
        let jeep = CellModel(carMakeText: "Jeep", carModelText: "Wrangler")
        let ford = CellModel(carMakeText: "Ford", carModelText: "F150")
        let bmw = CellModel(carMakeText: "BMW", carModelText: "2002")
        let ferrari = CellModel(carMakeText: "Ferrari", carModelText: "F430")
        let nissan = CellModel(carMakeText: "Nissan", carModelText: "Altima")
        let cars = [porsche, honda, volkswagen, subaru, jeep, ford, bmw, ferrari, nissan]
        return cars
    }
    
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func cellForRow(at index: Int) -> CellModel? {
        return cellModels[index]
    }
    
    func send(_ action: Action) {
        switch action {
        case .cellTapped(indexPath: let indexPath):
            print("cell tapped at \(indexPath.row)")
        case .firstButtonTapped:
            print("1st Button tapped")
        case .secondButtonTapped:
            print("2nd Button tapped")
        }
    }
    
}
