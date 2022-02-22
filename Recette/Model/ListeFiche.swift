//
//  ListeFiche.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
struct ListeFiche{
    var listFiche = [Fiche] ()
    
    mutating func addFiche(fiche : Fiche){
        self.listFiche.append(fiche)
    }
}
