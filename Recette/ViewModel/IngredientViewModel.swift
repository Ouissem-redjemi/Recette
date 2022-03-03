//
//  IngredientViewModel.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//


import Foundation
import Combine
import FirebaseFirestore

protocol IngredientDelegate {
    func change(allergene : Allergene)
    func change(categorie : CategorieIngredient)
    func change(code : String)
    func change(libelle : String)
    func change(prix_unitaire : Double)
    func change(unite : String)
}

class IngredientViewModel : IngredientDelegate, ObservableObject, Subscriber{
    
    typealias Input = IngredientIntentState
    
    typealias Failure = Never
    
    private var db = Firestore.firestore()
    
    func change(allergene: Allergene) {
        self.allergene = allergene
    }
    
    func change(categorie: CategorieIngredient) {
        self.categorie = categorie
    }
    
    func change(code: String) {
        self.code = code
    }
    
    func change(libelle: String) {
        self.libelle = libelle
    }
    
    func change(prix_unitaire: Double) {
        self.prix_unitaire = prix_unitaire
    }
    
    func change(unite : String) {
        self.unite = unite
    }
    

    
    var delegate : IngredientDelegate?

    
    public var ingredient : Ingredient
    
    @Published var allergene : Allergene
    @Published var categorie : CategorieIngredient
    @Published var code : String
    @Published var libelle : String
    @Published var prix_unitaire : Double
    @Published var unite : String

    
    
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited) // unlimited : on veut recevoir toutes les valeurs
    }
    
    // au cas où le publisher déclare qu'il finit d'émetter : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }

     // Activée à chaque send() du publisher :
    func receive(_ input: IngredientIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
       switch input{
          case .ready:
             break
          case .libelleChanging(let libelle):
           self.ingredient.libelle = libelle
       case .allergeneChanging(let allergene):
           self.ingredient.allergene = allergene
       case .categorieChanging(let categorie):
           self.ingredient.categorie = categorie
       case .prixUnitaireChanging(let prix):
           self.ingredient.prix_unitaire = Double(prix)
       case .uniteChanging(let unite):
           self.ingredient.unite = unite
       case .codeChanging(let code):
           self.ingredient.code = code
       case .listUpdated:
          break
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    
    init(from ingredient : Ingredient){
        self.ingredient = ingredient
        self.categorie = ingredient.categorie
        self.libelle = ingredient.libelle
        self.unite = ingredient.unite
        self.prix_unitaire = ingredient.prix_unitaire
        self.code = ingredient.code
        self.allergene = ingredient.allergene
        self.ingredient.delegate = self
    }
    
    //Ajouter un ingredient
    func addData(libelle : String, categorie : CategorieIngredient.RawValue, allergene : Allergene.RawValue, code : String , prix_unitaire : Double , unite : String){
        db.collection("ingredients").addDocument(data: ["libelle" : libelle, "categorie" : categorie, "allergene" : allergene, "code" : code, "prix_unitaire": prix_unitaire, "unite" : unite ])
         
     }
    
    func UpdateData(ingredient : IngredientViewModel){
        if let docId = ingredient.ingredient.idIngredient {
               db.collection("ingredients").document(docId).updateData([
                       "libelle": ingredient.libelle,
                       "categorie": ingredient.categorie.rawValue  ,
                       "allergene": ingredient.allergene.rawValue,
                       "code": ingredient.code,
                       "prix_unitaire": ingredient.prix_unitaire,
                       "unite": ingredient.unite
                    ])
                }
            }
        
        //Remove a recipe from the list of recipes
        func removeData(){
            if let docId = ingredient.idIngredient{
                db.collection("ingredients").document(docId).delete{
                    error in
                    if let error = error {
                        print("L'erreur est : \(error.localizedDescription)")
                    }
                }
            }
        }
    
    
}
