//
//  CategoryCollectionViewCell.swift
//  sample
//
//  Created by Asaph on 13/01/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var roundView: UIView!
    
    let colors: [UIColor] = [
        UIColor(red: 250/255, green: 231/255, blue: 231/255, alpha: 1),
        UIColor(red: 247/255, green: 243/255, blue: 201/255, alpha: 1),
        UIColor(red: 252/255, green: 240/255, blue: 241/255, alpha: 1),
        UIColor(red: 233/255, green: 219/255, blue: 244/255, alpha: 1),
        UIColor(red: 255/255, green: 242/255, blue: 217/255, alpha: 1)
    ]

    var cellViewModel: CategoryCellViewModel? {
        didSet {
            if let url = cellViewModel?.imageURL {
                self.categoryImageView.load(url: url)
            }
            self.categoryLabel.text = cellViewModel?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        self.roundView.layer.cornerRadius = (self.roundView.frame.height / 2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categoryImageView.image = nil
        self.categoryLabel.text = nil
    }
    
    func setCell(cellViewModel: CategoryCellViewModel, indexPath: IndexPath) {
        self.cellViewModel = cellViewModel
        self.roundView.backgroundColor = self.colors[(indexPath.row % 5)]
    }
}
