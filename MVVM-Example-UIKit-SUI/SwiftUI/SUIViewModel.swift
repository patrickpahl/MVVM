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

struct City: Identifiable {
    var id = UUID()
    let cityText: String
    let stateText: String
}

class SUIViewModel: ViewModel {
    
    weak var actionDelegate: SUIDelegate?
    
    enum State {
        case loading
        case loaded
        case error
    }
    
    enum Action {
        case buttonPressed
    }
    
    @Published var state: State = .loading
    @Published var nameText: String = ""
    var cities: [City] = []
    
    init(actionDelegate: SUIDelegate?) {
        self.actionDelegate = actionDelegate
    }
    
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
        case .buttonPressed:
            print("Name: \(nameText)")
        }
    }
    
    private func createMockData() -> [City] {
        let atx = City(cityText: "Austin", stateText: "TX")
        let sd = City(cityText: "San Diego", stateText: "CA")
        let slc = City(cityText: "Salt Lake City", stateText: "UT")
        let bos = City(cityText: "Boston", stateText: "MA")
        let den = City(cityText: "Denver", stateText: "CO")
        let sf = City(cityText: "San Francisco", stateText: "CA")
        let lv = City(cityText: "Las Vegas", stateText: "NV")
        let chi = City(cityText: "Chicago", stateText: "IL")
        let mia = City(cityText: "Miami", stateText: "FL")
        let atl = City(cityText: "Atlanta", stateText: "GA")
        let sea = City(cityText: "Seattle", stateText: "WA")
        let nyc = City(cityText: "New York City", stateText: "NY")
        let okc = City(cityText: "Oklahoma City", stateText: "OK")
        return [atx, sd, slc, bos, den, sf, lv, chi, mia, atl, sea, nyc, okc]
    }
    
}
