//
//  UIKViewModel.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/20/23.
//

import Foundation
import Combine

protocol UIKDelegate: AnyObject {
    func cellSelected(cell: CellModel)
}

class UIKViewModel: ViewModel {
    
    enum State {
        case loading
        case loaded
        case error
    }

    enum Action {
        case cellTapped(indexPath: IndexPath)
        case sortAlphabetically
        case sortByPrice
    }
    
    // MARK: Properties
    weak var actionDelegate: UIKDelegate?
    @Published var state: State = .loading
    var cellModels: [CellModel] = []
    
    // MARK: Init
    init(actionDelegate: UIKDelegate) {
        self.actionDelegate = actionDelegate
    }
    
    // MARK: Methods
    func send(_ action: Action) {
        
        switch action {
        case .cellTapped(indexPath: let indexPath):
            let cellSelected = cellModels[indexPath.row]
            actionDelegate?.cellSelected(cell: cellSelected)
            
        case .sortAlphabetically:
            state = .loading
            cellModels = cellModels.sorted(by: { $0.carMakeText < $1.carMakeText })
            state = .loaded
            
        case .sortByPrice:
            state = .loading
            cellModels = cellModels.sorted(by: { $0.price > $1.price })
            state = .loaded
        }
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
        let porsche = CellModel(carMakeText: "Porsche", carModelText: "911", price: 120000)
        let honda = CellModel(carMakeText: "Honda", carModelText: "Accord", price: 30000)
        let volkswagen = CellModel(carMakeText: "Volkswagen", carModelText: "GTI", price: 32000)
        let subaru = CellModel(carMakeText: "Subaru", carModelText: "WRX", price: 35000)
        let jeep = CellModel(carMakeText: "Jeep", carModelText: "Wrangler", price: 38000)
        let ford = CellModel(carMakeText: "Ford", carModelText: "F150", price: 28000)
        let bmw = CellModel(carMakeText: "BMW", carModelText: "2002", price: 50000)
        let ferrari = CellModel(carMakeText: "Ferrari", carModelText: "F430", price: 200000)
        let nissan = CellModel(carMakeText: "Nissan", carModelText: "Altima", price: 27000)
        let cars = [porsche, honda, volkswagen, subaru, jeep, ford, bmw, ferrari, nissan]
        return cars
    }
    
    // MARK: TableView Methods
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CellModel? {
        return cellModels[indexPath.row]
    }
    
}
