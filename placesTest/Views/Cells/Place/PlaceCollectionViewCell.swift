//
//  PlaceCollectionViewCell.swift
//  placesTest
//
//  Created by André Alves on 22/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {

    static let identifier = "PlaceCollectionViewCell"
    static let nib = UINib(nibName: "PlaceCollectionViewCell", bundle: nil)
    
    private let placeholderColors: [UIColor] = [#colorLiteral(red: 0.816, green: 0.89, blue: 0.937, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.855, blue: 0.878, alpha: 1.0), #colorLiteral(red: 0.988, green: 1.0, blue: 0.694, alpha: 1.0)]
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var imgVwPicture: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var vwClassification: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgVwPicture.roundCorners([.topRight, .topLeft], radius: 16)
    }
    
    override func prepareForReuse() {
        if let view = vwClassification.subviews.first as? ClassificationView {
            view.removeFromSuperview()
        }
    }
    
    func configure(with place: Place, and index: Int) {
        lblName.text = place.name
        lblType.text = place.type
        imgVwPicture.backgroundColor = selectPlaceholderColor(with: index)
        vwClassification.addSubview(ClassificationView.configure(with: 5, evaluation: place.review))
    }
    
    private func selectPlaceholderColor(with index: Int) -> UIColor {
        if index >= placeholderColors.count {
            return selectPlaceholderColor(with: index - 3)
        } else {
            return placeholderColors[index]
        }
    }

}
