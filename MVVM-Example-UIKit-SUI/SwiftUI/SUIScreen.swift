//
//  MainScreen.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/27/23.
//

import SwiftUI

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
                        Text("\(city.cityText), \(city.stateText)")
                    }
                    
                    Text(viewModel.nameText)
                        .bold()
                        .font(.system(size: 18))
                    
                    TextField("Enter a name", text: $viewModel.nameText)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.send(.buttonPressed)
                        }) {
                            Text("Do Something")
                                .bold()
                                .font(.system(size: 20))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(8)
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
