//
//  BannerCollectionViewCell.swift
//  sample
//
//  Created by Asaph on 15/01/23.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bannerImageView: UIImageView!

    var cellViewModel: BannerCellViewModel? {
        didSet {
            if let url = cellViewModel?.bannerURL {
                self.bannerImageView.load(url: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        self.bannerImageView.layer.cornerRadius = 5.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bannerImageView.image = nil
    }
    
    func setCell(cellViewModel: BannerCellViewModel) {
        self.cellViewModel = cellViewModel
    }
}
