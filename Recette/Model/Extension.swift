//
//  Extension.swift
//  Recette
//
//  Created by Souhaila kesbi on 04/03/2022.
//

import Foundation
extension Double {
    var cleanValue: String {
        return self / 1 == 0 ? String(format: "%.0f", self) : String(self)
    }
}
