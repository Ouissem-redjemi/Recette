//
//  ListAllergene.swift
//  Recette
//
//  Created by Souhaila kesbi on 24/02/2022.
//

import Foundation
struct ListAllergene{
    
    var listAllergene = [Allergene] ()
    
    mutating func addAllergene(allergene : Allergene){
        self.listAllergene.append(allergene)
    }
}
