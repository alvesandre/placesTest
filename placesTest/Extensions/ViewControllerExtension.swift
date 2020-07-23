//
//  ViewControllerExtension.swift
//  placesTest
//
//  Created by André Alves on 22/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(with error: Error, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if let completion = completion {
                completion()
            }
        }))
        self.navigationController?.present(alertController, animated: true)
    }
}
