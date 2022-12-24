//
//  CartCollectionViewCell.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 23.12.22.
//

import UIKit
import Kingfisher


protocol CartCollectionViewCellDelegate: AnyObject {
    func didRemove(food: Food)
}

class CartCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceAmountLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    
    weak var delegate: CartCollectionViewCellDelegate?
    private var food: Food?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.image = UIImage(named: "bin")
        iconImageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didSelectRemove))
        )
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.4
        layer.cornerRadius = 6

    }
    
    func configure(item: Food?) {
        guard let item = item else { return }
        self.food = item
        titleLabel.text = item.name
        titleLabel.font = .boldSystemFont(ofSize: 18)
//
        priceAmountLabel.text = "Count: \(item.orderAmount ?? 0): "
        priceLabel.text = "Price"
        priceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        priceAmountLabel.text = "\(item.price ?? 0) AZN "
        priceAmountLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        imgView.kf.setImage(with: item.imageURL)
    }

    @objc
    func didSelectRemove() {
        guard let food = food else { return }
        delegate?.didRemove(food: food)
    }
}

    
