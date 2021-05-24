//
//  SNCollectionViewController.swift
//  CollectionViewProgrammatically
//
//  Created by solo on 2021/5/21.
//  Copyright © 2021 ssn. All rights reserved.
//
// [All you need to know about UICollectionViewCompositionalLayout](https://medium.com/flawless-app-stories/all-what-you-need-to-know-about-uicollectionviewcompositionallayout-f3b2f590bdbe)

import UIKit

private let reuseIdentifier = "Cell"

class SNCollectionViewController: UICollectionViewController {
    
    let titleArr = ["auto fit label and image","edged list", "complex group"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "collection"
        collectionView.backgroundColor = .secondarySystemBackground

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(SNTitleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.collectionViewLayout = createLayout()
        
        // Do any additional setup after loading the view.
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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
        var title = ""
        if indexPath.row >= titleArr.count {
            title = titleArr.first!
        } else {
            title = titleArr[indexPath.row]
        }
        cell.lblTitle.text = "\(indexPath.section) \(indexPath.row) \(title)"
    
        return cell
    }

}

extension SNCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "estimate", sender: nil)
        case 1:
            navigationController?.pushViewController(SNEdgedListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
        default:
            break
        }
    }
}
