//
//  DashboardViewController.swift
//  sample
//
//  Created by Asaph on 13/01/23.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    
    var shopItemsViewModel = ShopItemsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.categoriesCollectionView.reloadData()
        }
        self.shopItemsViewModel.reloadCategoryCollectionView = {
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadData()
            }
        }
        
        self.shopItemsViewModel.reloadBannerCollectionView = {
            DispatchQueue.main.async {
                self.bannersCollectionView.reloadData()
            }
        }
        
        self.shopItemsViewModel.reloadProductCollectionView = {
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
        
        self.shopItemsViewModel.getShopItems()
    }

}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoriesCollectionView {
            return self.shopItemsViewModel.categoryCellModels.count
        } else if collectionView == self.bannersCollectionView {
            return self.shopItemsViewModel.bannerCellViewModels.count
        } else if collectionView == self.productsCollectionView {
            return self.shopItemsViewModel.productCellViewModels.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell
            cell?.setCell(cellViewModel: self.shopItemsViewModel.categoryCellModels[indexPath.row], indexPath: indexPath)
            return cell ?? UICollectionViewCell()
        } else if collectionView == self.bannersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCollectionViewCell
            cell?.setCell(cellViewModel: self.shopItemsViewModel.bannerCellViewModels[indexPath.row])
            return cell ?? UICollectionViewCell()
        } else if collectionView == self.productsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell
            cell?.setCell(cellViewModel: self.shopItemsViewModel.productCellViewModels[indexPath.row])
            return cell ?? UICollectionViewCell()
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = self.view.frame.width
        var height = self.categoriesCollectionView.frame.height
        if collectionView == self.categoriesCollectionView {
            width = (self.view.frame.width / 4) - 10
            height = self.categoriesCollectionView.frame.height - 20.0
        } else if collectionView == self.bannersCollectionView {
            width = (self.view.frame.width / 1.15) - 10
            height = self.bannersCollectionView.frame.height
        } else if collectionView == self.productsCollectionView {
            width = (self.view.frame.width / 2.15) - 10
            height = self.productsCollectionView.frame.height
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.productsCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 10.0)
    }
}

