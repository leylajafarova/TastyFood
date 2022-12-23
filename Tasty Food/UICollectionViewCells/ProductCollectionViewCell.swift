//
//  ProductCollectionViewCell.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 12/20/22.
//

import UIKit
import Kingfisher

protocol ProductCollectionViewCellDelegate: AnyObject {
    func didSelect(food: Food)
}

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    weak var delegate: ProductCollectionViewCellDelegate?
    private var food: Food?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.4
        layer.cornerRadius = 6
        
    }
    
    func configure(item: Food) {
        self.food = item
        titleLabel.text = item.name
        
        subtitleLabel.text = "\(item.price ?? 0) AZN"
        imageView.kf.setImage(with: item.imageURL)
    }

    @IBAction func didSelect(_ sender: UIButton) {
        guard let food = food else { return }
        delegate?.didSelect(food: food)
    }
}
