//
//  Fiche.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import FirebaseFirestoreSwift
class Fiche : Identifiable, Hashable, Equatable{
    
    //-----------------------  fonction Hashable   ------------------------------
    func hash(into hasher: inout Hasher) {
        hasher.combine(idFiche)
    }
    
    //-----------------------  fonction Equatable   ------------------------------
    static func ==(lhs: Fiche, rhs: Fiche) -> Bool {
        return lhs.idFiche == rhs.idFiche
    }
    
    var delegate : FicheDelegate?

    @DocumentID var idFiche : String?
    
    
    
    //-----------------------  Déclaration des prop  ------------------------------

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

    
    public var cout : Double?
    
    public var ingredients : [String : Double ]?
    public var etapes : [String]
    public var description : String? = ""
    public var duree : Int? = 5
    public var titleStep : String? = ""
 
    
    
    //----------------------- Init  ------------------------------
    init(id: String, categorie : CategorieRecette = CategorieRecette.dessert, title : String = "" ,materielDressage : String? = "" , materielSpecifique : String? = "" , responsable : String = "" , nbCouverts : Int = 0, etapes : [String] = [], description : String? = "", duree : Int? = 5 , titleStep : String? = "", ingredients : [String : Double] = [:], cout : Double = 0 ){
        self.idFiche = id
        self.categorie = categorie
        self.title = title
        self.materielDressage = materielDressage
        self.materielSpecifique = materielSpecifique
        self.responsable = responsable
        self.nbCouverts = nbCouverts
        self.etapes = etapes
        self.titleStep = titleStep
        self.duree = duree
        self.description = description
        self.ingredients = ingredients
        self.cout = cout 
    }
}

