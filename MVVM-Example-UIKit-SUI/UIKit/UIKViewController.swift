//
//  UIKViewController.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/20/23.
//

import UIKit
import Combine

class UIKViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.identifier)
        return tableView
    }()
    
    private let firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("First Button", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Second Button", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .red
        return activityIndicator
    }()

    var viewModel: UIKViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: UIKViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "UIKit MVVM"
        setUpViews()
        setUpSubscribers()
        viewModel.loadData()
    }
    
    private func setUpViews() {
        view.addSubview(tableView)
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: firstButton.topAnchor, constant: 20).isActive = true
        
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        firstButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        firstButton.bottomAnchor.constraint(equalTo: secondButton.topAnchor, constant: -30).isActive = true
        
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        secondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        secondButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setUpSubscribers() {
        
        viewModel.$state.sink { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loading:
                print("handle loading state")
            case .loaded:
                self.tableView.reloadData()
            case .error:
                print("handle error state")
            }
        }.store(in: &cancellables)
    }
    
    @objc func firstButtonTapped() {
        viewModel.send(.firstButtonTapped)
    }

    @objc func secondButtonTapped() {
        viewModel.send(.secondButtonTapped)
    }
}

extension UIKViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier, for: indexPath) as? GenericTableViewCell,
              let cellModel = viewModel.cellForRow(at: indexPath) else { return UITableViewCell() }
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "\(cellModel.carMakeText) \(cellModel.carModelText)"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        containerView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        
        cell.addContent(view: containerView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.send(.cellTapped(indexPath: indexPath))
    }
}
