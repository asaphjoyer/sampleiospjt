//
//  ShopItemsViewModel.swift
//  sample
//
//  Created by asaph on 14/01/23.
//

import Foundation

class ShopItemsViewModel: NSObject {
    private var shopService: ShopServiceProtocol
    
    var reloadCategoryCollectionView: (() -> Void)?
    var reloadBannerCollectionView: (() -> Void)?
    var reloadProductCollectionView: (() -> Void)?
    
    var shopItems: ShopItems?
    
    var categoryCellModels = [CategoryCellViewModel]() {
        didSet {
            self.reloadCategoryCollectionView?()
        }
    }
    
    var bannerCellViewModels = [BannerCellViewModel]() {
        didSet {
            self.reloadBannerCollectionView?()
        }
    }
    
    var productCellViewModels = [ProductCellViewModel]() {
        didSet {
            self.reloadProductCollectionView?()
        }
    }
    
    init(shopItemService: ShopServiceProtocol = ShopService()) {
        self.shopService = shopItemService
    }
    
    func getShopItems() {
        self.shopService.getShopItems() { success, model, error in
            if success, let shopItems = model {
                self.shopItems = shopItems
                self.fetchData(type: "category")
                self.fetchData(type: "banners")
                self.fetchData(type: "products")
            } else {
                print(error ?? "Error")
            }
        }
    }
    
    func fetchData(type: String) {
        guard let categories = self.shopItems?.homeData.filter({ $0.type == type }) else { return }
        if type == "category" {
            self.setCategoryCellModels(homeData: categories)
        } else if type == "banners" {
            self.setBannerCellModels(homeData: categories)
        } else if type == "products" {
            self.setProductCellModels(homeData: categories)
        }
    }
    
    func setCategoryCellModels(homeData: [HomeData]) {
        var categoryCellModels: [CategoryCellViewModel] = []
        homeData.first?.values.forEach({
            let id = $0.id
            let imageUrl = URL(string: $0.image_url ?? "")
            let categoryName = $0.name
            let categoryCellViewModel = CategoryCellViewModel(id: id, imageURL: imageUrl, name: categoryName)
            categoryCellModels.append(categoryCellViewModel)
        })
        self.categoryCellModels = categoryCellModels
    }
    
    func setBannerCellModels(homeData: [HomeData]) {
        var bannerCellViewModels: [BannerCellViewModel] = []
        homeData.first?.values.forEach({
            let id = $0.id
            let bannerUrl = URL(string: $0.banner_url ?? "")
            let bannerCellViewModel = BannerCellViewModel(id: id, bannerURL: bannerUrl)
            bannerCellViewModels.append(bannerCellViewModel)
        })
        self.bannerCellViewModels = bannerCellViewModels
    }
    
    func setProductCellModels(homeData: [HomeData]) {
        var productCellViewModels: [ProductCellViewModel] = []
        homeData.first?.values.forEach({
            let id = $0.id
            let imageUrl = URL(string: $0.image ?? "")
            let productName = $0.name
            let actualPrice = $0.actual_price
            let offerPrice = $0.offer_price
            let offer = $0.offer
            let isExpress = $0.is_express
            let productCellViewModel = ProductCellViewModel(id: id, image: imageUrl, name: productName, actualPrice: actualPrice, offerPrice: offerPrice, offer: offer, isExpress: isExpress)
            productCellViewModels.append(productCellViewModel)
        })
        self.productCellViewModels = productCellViewModels
    }
}
