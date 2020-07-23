//
//  ClassificationView.swift
//  placesTest
//
//  Created by André Alves on 22/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit

class ClassificationView: UIView {

    @IBOutlet weak var stackVwItems: UIStackView!
    @IBOutlet weak var lblEvaluationValue: UILabel!
    
    static func configure(with numberOfItems: Int, evaluation: Double, fontColor: UIColor = .black) -> ClassificationView {
        guard let vwClassification = Bundle.main.loadNibNamed("ClassificationView", owner: self, options: nil)?.first as? ClassificationView else {
            return ClassificationView()
        }
        let evaluationCeil = ceil(evaluation)
        for i in 1...numberOfItems {
            let imageView = UIImageView(image: Double(i) <= evaluationCeil ? #imageLiteral(resourceName: "star_on") : #imageLiteral(resourceName: "star_off"))
            imageView.contentMode = .scaleAspectFit
            vwClassification.stackVwItems.addArrangedSubview(imageView)
        }
        vwClassification.lblEvaluationValue.textColor = fontColor
        vwClassification.lblEvaluationValue.text = String(evaluation)
        return vwClassification
    }

}
