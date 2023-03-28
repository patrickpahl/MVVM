//
//  GenericTableViewCell.swift
//  MVVM-Example-UIKit-SUI
//
//  Created by Patrick Pahl on 3/20/23.
//

import UIKit

protocol RegisterableCell: AnyObject {
    static var identifier: String { get }
}

class GenericTableViewCell: UITableViewCell, RegisterableCell {
    static let identifier = "GenericTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func addContent(view: UIView, withPadding padding: UIEdgeInsets = .zero) {
        contentView.subviews.forEach({ $0.removeFromSuperview() })
        
        contentView.addSubview(view)
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding.left).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding.right).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding.bottom).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding.top).isActive = true
    }
}
