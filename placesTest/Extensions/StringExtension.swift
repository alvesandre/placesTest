//
//  StringExtension.swift
//  placesTest
//
//  Created by André Alves on 23/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import Foundation

extension String {
    public var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    public func formatPhone() -> String {
        let telefone = self.digits

        let index1 = telefone.index(telefone.startIndex, offsetBy: 2)
        let index2 = telefone.index(telefone.startIndex, offsetBy: 4)
        let index3 = telefone.index(telefone.startIndex, offsetBy: self.digits.count == 13 ? 9 : 8)

        let parte1 = String(telefone[..<index1])
        let parte2 = String(telefone[index1..<index2])
        let parte3 = String(telefone[index2..<index3])
        let parte4 = String(telefone[index3...])

        return String(format: "+%@ %@ %@ %@", parte1, parte2, parte3, parte4)
    }
}

