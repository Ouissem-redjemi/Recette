//
//  Fiche.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
class Fiche {
    
    var delegate : FicheDelegate?
    
    public var categorie : CategorieRecette
    public var title : String {
        didSet{
            self.delegate?.change(title: self.title)
        }
    }
    public var materielDressage : String? {
        didSet{
            self.delegate?.change(materielDressage: self.materielDressage)
        }
    }
    public var materielSpecifique : String? {
        didSet{
            self.delegate?.change(materielSpecifique: self.materielSpecifique)
        }
    }
    public var responsable : String{
        didSet{
            self.delegate?.change(responsable: self.responsable)
        }
    }
    public var nbCouverts : Int {
        didSet{
            self.delegate?.change(nbCouverts: self.nbCouverts)
        }
    }
    public var quantite : [Double : Ingredient ]
    public var etapes : [String   : [Double : Ingredient  ] ]
    // Ici on pourrait faire un dictionnaire des etapes vue que on doit pas stocker les etapes en tant que que element de la base de donnée du coup on pourrait apres juste recupere les recettes avec leurs etapes en tant que dico et pouvoir les reutiliser
    
    init(categorie : CategorieRecette , title : String ,materielDressage : String? , materielSpecifique : String? , responsable : String , nbcCouverts : Double , etapes :  [String   : [Double : Ingredient  ] ], quantite :[Double : Ingredient  ] ){
        self.categorie = categorie
        self.title = title
        self.materielDressage = materielDressage
        self.materielSpecifique = materielSpecifique
        self.responsable = responsable
        self.nbCouverts = nbcCouverts
        self.etapes = etapes
        self.quantite = quantite
    }
}

