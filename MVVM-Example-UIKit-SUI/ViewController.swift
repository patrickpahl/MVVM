//
//  ViewController.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/20/23.
//

import UIKit

class ViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "MVVM Example"
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.textColor = .white
        return label
    }()
    
    private let uiKitButton: UIButton = {
        let button = UIButton()
        button.setTitle("UIKit", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(goToUIKitExample), for: .touchUpInside)
        return button
    }()
    
    private let swiftUIButton: UIButton = {
        let button = UIButton()
        button.setTitle("SwiftUI", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(goToSwiftUIExample), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    private func setUpViews() {
        view.addSubview(label)
        view.addSubview(uiKitButton)
        view.addSubview(swiftUIButton)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        uiKitButton.translatesAutoresizingMaskIntoConstraints = false
        uiKitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uiKitButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50).isActive = true
        
        swiftUIButton.translatesAutoresizingMaskIntoConstraints = false
        swiftUIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiftUIButton.topAnchor.constraint(equalTo: uiKitButton.bottomAnchor, constant: 40).isActive = true
    }
    
    @objc func goToUIKitExample() {
        let viewModel = UIKitExampleViewModel()
        let viewController = UIKitExampleViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func goToSwiftUIExample() {
        print("TODO - SwiftUI")
    }
}

