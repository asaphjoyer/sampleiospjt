//
//  ProductCollectionViewCell.swift
//  sample
//
//  Created by Asaph on 15/01/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var expressImageView: UIImageView!
    @IBOutlet weak var offerView: UIView!
    
    var cellViewModel: ProductCellViewModel? {
        didSet {
            if let url = self.cellViewModel?.image {
                self.productImageView.load(url: url)
            }
            self.productLabel.text = self.cellViewModel?.name
            self.actualPriceLabel.text = self.cellViewModel?.actualPrice
            self.offerPriceLabel.text = self.cellViewModel?.offerPrice
            self.offerLabel.text = "\(self.cellViewModel?.offer ?? 0)% OFF"
            self.expressImageView.isHidden = self.cellViewModel?.isExpress ?? true
            self.offerLabel.alpha = self.cellViewModel?.actualPrice == self.cellViewModel?.offerPrice ? 0 : 1
            self.offerView.alpha = self.offerLabel.alpha
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImageView.image = nil
        self.productLabel.text = nil
        self.actualPriceLabel.text = nil
        self.offerPriceLabel.text = nil
        self.offerLabel.text = nil
        self.expressImageView.image = nil
    }
    
    func setCell(cellViewModel: ProductCellViewModel) {
        self.cellViewModel = cellViewModel
    }
}
