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
    
    let separatorLine: UIView = {
        let one = UIView()
        one.backgroundColor = .separator
        one.translatesAutoresizingMaskIntoConstraints = false
        
        return one
    }()
    
    let indicatorImg: UIImageView = {
        let one = UIImageView(image: UIImage(systemName: "chevron.right"))
        one.contentMode = .scaleAspectFit
        one.translatesAutoresizingMaskIntoConstraints = false
        
        return one
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lblTitle)
        contentView.addSubview(separatorLine)
        contentView.addSubview(indicatorImg)

        NSLayoutConstraint.activate([
            
            separatorLine.heightAnchor.constraint(equalToConstant: NSCollectionLayoutDimension.fractionalWidth(0.5).dimension),//1 / UIScreen.main.scale),
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            indicatorImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indicatorImg.heightAnchor.constraint(equalToConstant: 20),
            indicatorImg.widthAnchor.constraint(equalToConstant: 20),
            indicatorImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            
            lblTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18)
            
        ])
        
        NSLayoutConstraint.activate([
            lblTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18)
        ])
        
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
