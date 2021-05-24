//
//  SNEdgedListCollectionViewController.swift
//  CollectionViewProgrammatically
//
//  Created by solo on 2021/5/23.
//  Copyright © 2021 ssn. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SNEdgedListCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "edged list"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(SNTitleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SNTitleCollectionViewCell
    
        // Configure the cell
        cell.lblTitle.text = "\(indexPath.section) \(indexPath.row)"
        cell.contentView.backgroundColor = .systemYellow
    
        return cell
    }


    private func createLayout() -> UICollectionViewLayout {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(0), top: nil,
                                                             trailing: .flexible(16), bottom: nil)
            let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                  heightDimension: .fractionalHeight(1))
            let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
            item2.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil,
                                                              trailing: .flexible(0), bottom: nil)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(60))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitems: [item, item2])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10

            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
}
