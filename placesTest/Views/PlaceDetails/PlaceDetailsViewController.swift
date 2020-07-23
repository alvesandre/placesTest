//
//  PlaceDetailsViewController.swift
//  placesTest
//
//  Created by André Alves on 23/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit
import PKHUD

class PlaceDetailsViewController: UIViewController {
    
    var placeID: Int = -1
    
    var placeholderColor: UIColor?
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var stkVwSchedule: UIStackView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var vwClassification: UIView!
    @IBOutlet weak var imgVwPicture: UIImageView!
    
    private var placeDetails: PlaceDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        HUD.show(.progress)
        API.shared.getPlaceDetails(with: placeID) { (result) in
            HUD.hide()
            switch(result) {
            case .success(let placeDetails):
                self.configure(with: placeDetails)
            case .failure(let error):
                self.showError(with: error, completion: {
                    self.back()
                })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func configure(with placeDetails: PlaceDetails) {
        if let placeholderColor = placeholderColor {
            imgVwPicture.backgroundColor = placeholderColor
        }
        lblName.text = placeDetails.name
        lblPhone.text = placeDetails.phone.formatPhone()
        lblAddress.text = placeDetails.adress
        lblAbout.text = placeDetails.about
        self.placeDetails = placeDetails
        for string in placeDetails.schedule.getGroups() {
            let label = UILabel()
            label.text = string
            label.font = UIFont(name: "OpenSans-Light", size: 14)
            label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            stkVwSchedule.addArrangedSubview(label)
        }
        vwClassification.addSubview(ClassificationView.configure(with: 5, evaluation: placeDetails.review, fontColor: .white))
    }
    
    @IBAction func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func share() {
        guard let placeDetails = placeDetails else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [placeDetails], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        self.present(activityViewController, animated: true, completion: nil)
    }

}
