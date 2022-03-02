//
//  Ingredient.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import Foundation
import FirebaseFirestoreSwift
class Ingredient : Identifiable, Hashable, Equatable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(idIngredient)
    }
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.idIngredient == rhs.idIngredient
    }
    
    public var delegate : IngredientDelegate?
    
    @DocumentID var idIngredient : String?
    public var allergene : Allergene{
        didSet{
            self.delegate?.change(allergene: self.allergene)
        }
    }
    public var categorie : CategorieIngredient{
        didSet{
            self.delegate?.change(categorie: self.categorie)
        }
    }
    public var code : String{
        didSet{
            self.delegate?.change(code: self.code)
        }
    }
    
    public var libelle : String{
        didSet{
            self.delegate?.change(libelle: self.libelle)
        }
    }
    
    public var prix_unitaire : Double{
        didSet{
            self.delegate?.change(prix_unitaire: self.prix_unitaire)
        }
    }
    public var unite : String{
        didSet{
            self.delegate?.change(unite: self.unite)
        }
    }
    
    
    init(idIngredient : String, allergene : Allergene = Allergene.soja, categorie : CategorieIngredient = CategorieIngredient.autre, code : String = "" , libelle : String = "" , prix_unitaire : Double = 0 , unite : String = "kg"){
        self.idIngredient = idIngredient
        self.allergene = allergene
        self.categorie = categorie
        self.code  = code
        self.libelle = libelle
        self.prix_unitaire = prix_unitaire
        self.unite = unite

    }
}
