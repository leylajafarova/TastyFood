//
//  ListScreenViewController.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 18.12.22.
//

import UIKit
import Kingfisher

class ListScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = ListScreenViewModel()
    
    @IBOutlet weak var ivFood: UIImageView!
    @IBOutlet weak var lblWlc: UILabel!
    @IBOutlet weak var src: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.fetchFoods { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        src.placeholder = "Search"
    }
    
    func setupCollectionView() {
        //This is how we register NIB for ProductCollectionViewCell
        collectionView.register(
            UINib(nibName: String(describing: ProductCollectionViewCell.self), bundle: nil),
            forCellWithReuseIdentifier: String(describing: ProductCollectionViewCell.self)
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
    }
}

extension ListScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = viewModel.foods[indexPath.row]

        //this is how we reuse it
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProductCollectionViewCell.self), for: indexPath
        ) as! ProductCollectionViewCell
        
        
        //configure moved to cell
        cell.configure(item: item)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Implement navigation to next screen there (select whole cell)
        let item = viewModel.foods[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailiewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as!DetailViewController
        detailiewController.food = item
        navigationController?.present(detailiewController, animated: true)
    }
}

extension ListScreenViewController: ProductCollectionViewCellDelegate {
    func didSelect(food: Food) {
        //select button on cell
        print("food selected: ", food.name)
    }
}

extension ListScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 24
        return .init(width: width, height: width)
    }
}

