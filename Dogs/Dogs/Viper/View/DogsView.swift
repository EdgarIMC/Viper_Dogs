//
//  DogsView.swift
//  ApiDogsViper
//
//  Created by 1017143 on 15/11/22.
//
//

import Foundation
import UIKit

class DogsView: UIViewController {

    @IBOutlet weak var mainPhotoDogImg: UIImageView!
    @IBOutlet weak var originCountryLbl: UILabel!
    @IBOutlet weak var liveAvgLbl: UILabel!
    @IBOutlet weak var raceLbl: UILabel!
    @IBOutlet weak var dogsCollection: UICollectionView! {
        didSet {
            dogsCollection.delegate = self
            dogsCollection.dataSource =  self
            dogsCollection.register(UINib.init(nibName: "DogsCollectionViewCell", bundle: Bundle(for: DogsView.self)), forCellWithReuseIdentifier: "DogsCollectionViewCell")
        }
    }
    
    // MARK: Properties
    var presenter: DogsPresenterProtocol?
    let numberOfSections = 1
    let insets: CGFloat = 8
    let heightAditionalConstant: CGFloat = 20
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow: Float = 2.3
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getDogs()
    }
}

extension DogsView: DogsViewProtocol {
    func showMainDog(dog: Dog) {
        DispatchQueue.main.async {
            self.mainPhotoDogImg.loadImage(urlStr: dog.image.url)
            self.originCountryLbl.text = dog.origin == "" ? "Unknown" : dog.origin
            self.raceLbl.text = dog.name
            self.liveAvgLbl.text =  dog.lifeSpan
        }
    }
  
    func showDogs() {
        DispatchQueue.main.async {
            self.dogsCollection?.reloadData()
        }
    }
    
    // TODO: implement view output methods
}

extension DogsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dog = presenter?.getDog(indexPath: indexPath.row)
        self.mainPhotoDogImg.loadImage(urlStr: dog?.image.url ?? "")
        self.originCountryLbl.text = dog?.origin == "" ? "Unknown" : dog?.origin
        self.raceLbl.text = dog?.name
        self.liveAvgLbl.text =  dog?.lifeSpan
    }
}

extension DogsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getTotalDogs() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogsCollectionViewCell", for: indexPath) as? DogsCollectionViewCell else {return UICollectionViewCell()}
        let dog = presenter?.getDog(indexPath: indexPath.row)
        cell.nameDogLbl.text = dog?.name
        cell.photoDogImg.loadImage(urlStr: dog?.image.url ?? "")
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DogsView: UICollectionViewDelegateFlowLayout {
    // swiftlint:disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginAndInsets: CGFloat
        marginAndInsets = minimumInteritemSpacing * 2
        + collectionView.safeAreaInsets.left
        + collectionView.safeAreaInsets.right + insets * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth + heightAditionalConstant)
    }
}
