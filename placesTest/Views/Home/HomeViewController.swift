//
//  HomeViewController.swift
//  placesTest
//
//  Created by André Alves on 22/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit
import PKHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var cltVwPlaces: UICollectionView!
    
    private var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureCollection()
        getPlaces()
        
    }
    
    private func configureCollection() {
        cltVwPlaces.register(PlaceCollectionViewCell.nib, forCellWithReuseIdentifier: PlaceCollectionViewCell.identifier)
        cltVwPlaces.delegate = self
        cltVwPlaces.dataSource = self
    }
    
    private func getPlaces() {
        HUD.show(.progress)
        API.shared.getPlaces { (result) in
            HUD.hide()
            switch(result) {
            case .success(let places):
                self.places = places
                self.cltVwPlaces.reloadData()
            case .failure(let error):
                self.showError(with: error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsSegue", let (placeID, placeholderColor) = sender as? (Int, UIColor), let placeDetailsVC = segue.destination as? PlaceDetailsViewController {
            placeDetailsVC.placeID = placeID
            placeDetailsVC.placeholderColor = placeholderColor
        }
    }
    
}

//MARK: - CollectionView Delegate and DataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.identifier, for: indexPath) as? PlaceCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: places[indexPath.row], and: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PlaceCollectionViewCell else {
            return
        }
        performSegue(withIdentifier: "goToDetailsSegue", sender: (places[indexPath.row].id, cell.imgVwPicture.backgroundColor))
    }
}
