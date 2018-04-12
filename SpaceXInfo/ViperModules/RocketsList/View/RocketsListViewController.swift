//
//  RocketsListViewController.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation
import ViperPoison

struct RocketCellViewModel {
    let title: String
    let isActive: Bool
}

class RocketCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activeStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
    }
    
    func config(with viewModel:RocketCellViewModel) {
        titleLabel.text = viewModel.title
        activeStatusLabel.text = viewModel.isActive ? "Active" : "Not active"
    }
}

protocol RocketsListViewOutput {
    func viewDidLoad()
    func numberOfItems() -> Int
    func item(at indexPath:IndexPath) -> RocketCellViewModel
    func didSelectItem(at indexPath:IndexPath)
}

protocol RocketsListViewInput: class {
    func reloadCollection()
}

class RocketsListViewController: ViperViewController {
    
    var output: RocketsListViewOutput!
    
    @IBOutlet weak var rocketsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        output.viewDidLoad()
    }
    
}

extension RocketsListViewController: RocketsListViewInput {
    func reloadCollection() {
        rocketsCollectionView.reloadData()
    }
}

extension RocketsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketCell", for: indexPath) as! RocketCollectionViewCell
        let viewModel = output.item(at: indexPath)
        cell.config(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.numberOfItems()
    }
}

extension RocketsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        return CGSize(width: collectionView.bounds.width - insets.left - insets.right, height: (collectionView.frame.height - insets.top - insets.bottom)/3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}
