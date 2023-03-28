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

protocol UIKitExampleDelegate: AnyObject {
    func doSomethingFirstButton()
    func doSomethingSecondButton()
}

class UIKitExampleViewModel: ViewModel {
    
    enum State {
        case loading
        case loaded
        case error
    }
    
    enum Action {
        case cellTapped(indexPath: IndexPath)
        case firstButtonTapped
        case secondButtonTapped
    }
    
    weak var actionDelegate: UIKitExampleDelegate?
    @Published var state: State = .loading
    var cellModels: [CellModel] = []
    
    init(actionDelegate: UIKitExampleDelegate) {
        self.actionDelegate = actionDelegate
    }
    
    func loadData() {
        state = .loading
        cellModels = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cellModels = self.createMockData()
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
    
    func cellForRow(at indexPath: IndexPath) -> CellModel? {
        return cellModels[indexPath.row]
    }
    
    func send(_ action: Action) {
        switch action {
        case .cellTapped(indexPath: let indexPath):
            print("cell tapped at \(indexPath.row)")
        case .firstButtonTapped:
            actionDelegate?.doSomethingFirstButton()
        case .secondButtonTapped:
            actionDelegate?.doSomethingSecondButton()
        }
    }
    
}
