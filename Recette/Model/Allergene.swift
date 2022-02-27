//
//  Allergene.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
class Allergene : Identifiable{
    public var libelle : String
    public var idAllergene : String 
    init(idAllergene : String , libelle : String ){
        self.libelle = libelle
        self.idAllergene = idAllergene
    }
}
