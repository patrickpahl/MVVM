//
//  MainScreen.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/27/23.
//

import SwiftUI

// MARK: SUI Screen
struct SUIScreen: View {
    
    @EnvironmentObject var viewModel: SUIViewModel
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                VStack {
                    ProgressView()
                }.onAppear {
                    viewModel.loadData()
                }
            case .loaded:
                VStack(alignment: .leading, spacing: 20) {
                    
                    List(viewModel.cities) { city in
                        CityView(city: city)
                    }
                    
                    Text(viewModel.nameText)
                        .bold()
                        .font(.system(size: 18))
                    
                    TextField("Enter a name", text: $viewModel.nameText)
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 30) {
                            Button(action: {
                                viewModel.send(.sortAlphabetically)
                            }) {
                                Text("Sort Alphabetically")
                                    .bold()
                                    .font(.system(size: 20))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                viewModel.send(.sortByPopulation)
                            }) {
                                Text("Sort by Population")
                                    .bold()
                                    .font(.system(size: 20))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        Spacer()
                    }
                }
                .padding(20)
            case .error:
                VStack {
                    Text("Error state")
                }
            }
        }
        .navigationTitle("SwiftUI")
    }
}


// MARK: City View
struct CityView: View {
    
    var city: CityModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(city.cityText), \(city.stateText)")
                .bold()
            Text(city.formattedPopulation)
        }
    }
}
