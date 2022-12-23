//
//  CartScreenViewController.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 19.12.22.
//

import UIKit
import Kingfisher

class CartScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    
    var viewModel = CartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCartItems { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func setupCollectionView() {
        //This is how we register NIB for ProductCollectionViewCell
        collectionView.register(
            UINib(nibName: String(describing: CartCollectionViewCell.self), bundle: nil),
            forCellWithReuseIdentifier: String(describing: CartCollectionViewCell.self)
        )

        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10

        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        collectionView.collectionViewLayout = layout

//        UIAlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
    }
   
    
}

extension CartScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width) - 32
        return .init(width: width, height: 150)
    }
}

extension CartScreenViewController: CartCollectionViewCellDelegate {
    func didRemove(food: Food) {
        viewModel.removeItem(food: food) { [weak self] in
            self?.collectionView.reloadData()
        }
        print("food selected: ", food.name)
        //servis kotoriy budet udalat i sdelat reload collection view
    }
}

extension CartScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.foods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = viewModel.foods[indexPath.row]

        //this is how we reuse it
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CartCollectionViewCell.self), for: indexPath
        ) as! CartCollectionViewCell


        //configure moved to cell
        cell.configure(item: item)
        cell.delegate = self
        return cell
    }
}
