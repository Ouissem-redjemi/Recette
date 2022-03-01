//
//  FicheDTO.swift
//  Recette
//
//  Created by Dalia Rdjm on 1/3/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct FicheDTO  {
    
    @DocumentID var idFiche : String? = UUID().uuidString
    public var categorie : CategorieRecette
    public var title : String
    public var materielDressage : String?
    public var materielSpecifique : String?
    public var responsable : String
    public var nbCouverts : Int
    
    enum CodingKeys : String, CodingKey {
    case idFiche
    case categorie
    case title
    case materielDressage
    case materielSpecifique
    case nbCouverts
    }
}
