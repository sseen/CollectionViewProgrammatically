//
//  SNTitleCollectionViewCell.swift
//  CollectionViewProgrammatically
//
//  Created by solo on 2021/5/22.
//  Copyright © 2021 ssn. All rights reserved.
//

import UIKit

class SNTitleCollectionViewCell: UICollectionViewCell {
    let lblTitle: UILabel = {
       let one = UILabel()
        one.translatesAutoresizingMaskIntoConstraints = false
        one.textColor = .label
        
        return one
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPurple
        contentView.addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
            lblTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18)
        ])
        
        contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
