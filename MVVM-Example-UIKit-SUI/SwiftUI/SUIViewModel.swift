//
//  SUIViewModel.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/27/23.
//

import Foundation

protocol SUIDelegate: AnyObject {
    func buttonPressed()
}

class SUIViewModel: ViewModel {
    
    enum State {
        case loading
        case loaded
        case error
    }
    
    enum Action {
        case sortAlphabetically
        case sortByPopulation
    }
    
    // MARK: Properties
    weak var actionDelegate: SUIDelegate?
    @Published var state: State = .loading
    @Published var nameText: String = ""
    @Published var cities: [CityModel] = []
    
    // MARK: Init
    init(actionDelegate: SUIDelegate?) {
        self.actionDelegate = actionDelegate
    }
    
    // MARK: Methods
    func loadData() {
        state = .loading
        cities = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.cities = self.createMockData()
            self.state = .loaded
        }
        
    }
    
    func send(_ action: Action) {
        
        switch action {
        case .sortAlphabetically:
            cities = cities.sorted(by: { $0.cityText < $1.cityText })
            actionDelegate?.buttonPressed()
            
        case .sortByPopulation:
            cities = cities.sorted(by: { $0.population > $1.population })
        }
    }
    
    private func createMockData() -> [CityModel] {
        let atx = CityModel(cityText: "Austin", stateText: "TX", population: 960000)
        let sd = CityModel(cityText: "San Diego", stateText: "CA", population: 1380000)
        let slc = CityModel(cityText: "Salt Lake City", stateText: "UT", population: 200000)
        let bos = CityModel(cityText: "Boston", stateText: "MA", population: 654000)
        let den = CityModel(cityText: "Denver", stateText: "CO", population: 711000)
        let sf = CityModel(cityText: "San Francisco", stateText: "CA", population: 815000)
        let lv = CityModel(cityText: "Las Vegas", stateText: "NV", population: 650000)
        let chi = CityModel(cityText: "Chicago", stateText: "IL", population: 2700000)
        let mia = CityModel(cityText: "Miami", stateText: "FL", population: 440000)
        let atl = CityModel(cityText: "Atlanta", stateText: "GA", population: 500000)
        let sea = CityModel(cityText: "Seattle", stateText: "WA", population: 733000)
        let nyc = CityModel(cityText: "New York City", stateText: "NY", population: 8500000)
        let okc = CityModel(cityText: "Oklahoma City", stateText: "OK", population: 690000)
        return [atx, sd, slc, bos, den, sf, lv, chi, mia, atl, sea, nyc, okc]
    }
    
}

// MARK: City Model
struct CityModel: Identifiable {
    var id = UUID()
    let cityText: String
    let stateText: String
    let population: Int
    
    var formattedPopulation: String {
        let population = NumberHelper.formatNumber(number: population)
        return "Population: \(population)"
    }
}

// MARK: Number Helper
class NumberHelper {
    static func formatNumber(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:number)) ?? ""
    }
}
