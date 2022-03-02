//
//  FicheViewModel.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import Combine
import FirebaseFirestore

protocol FicheDelegate{
    func change(categorie : CategorieRecette)
    func change(title : String)
    func change(materielDressage : String?)
    func change(materielSpecifique : String?)
    func change(responsable : String)
    func change(nbCouverts : Int)
        
}

class FicheViewModel : FicheDelegate , ObservableObject, Subscriber{
    typealias Input = FicheIntentState
    
    typealias Failure = Never
    
    
    private var fiche : Fiche
    //Get a reference to the database
    private var db = Firestore.firestore()
    @Published var categorie : CategorieRecette
    @Published var title : String
    @Published var materielDressage : String?
    @Published var materielSpecifique : String?
    @Published var responsable : String
    @Published var nbCouverts : Int
   // @Published var quantite : [Double : Ingredient  ]
   // @Published var etapes : [String   : [Double : Ingredient  ] ]
    
    func change(categorie: CategorieRecette) {
        self.categorie = categorie
    }
    
    func change(title: String) {
        self.title = title
    }
    
    func change(materielDressage: String?) {
        self.materielDressage = materielDressage
    }
    
    func change(materielSpecifique: String?) {
        self.materielSpecifique = materielSpecifique
    }
    
    func change(responsable: String) {
        self.responsable = responsable
    }
    
    func change(nbCouverts: Int) {
        self.nbCouverts = nbCouverts
    }
    
   /* func change(etapes : [String   : [Double : Ingredient  ] ]){
        self.etapes = etapes
    }
    
    func change(quantite :[Double : Ingredient  ] ){
        self.quantite = quantite
    }*/
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited) // unlimited : on veut recevoir toutes les valeurs
    }
    
    // au cas où le publisher déclare qu'il finit d'émetter : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }

     // Activée à chaque send() du publisher :
    func receive(_ input: FicheIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
       switch input{
          case .ready:
             break
          case .titleChanging(let title):
           self.fiche.title = title
       case .responsableChanging(let responsable):
           self.fiche.responsable = responsable
       case .matSpeChanging(let materielSpecifique):
           self.fiche.materielSpecifique = materielSpecifique
       case .matDressChanging(let materielDressage):
           self.fiche.materielDressage = materielDressage
       case .couvertChanging(let couvert):
           self.fiche.nbCouverts = Int(couvert)
        case .listUpdated:
           break
           
          
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    
   

  /*  public var coutSimple : Double{
        var total : Double = 0
        for (_, _) in etapes{
            for (qte , ingredient) in quantite{
                total = total + ingredient.prix_unitaire * qte
            }
        }
        return total
    }*/

    
    init(from fiche : Fiche){
        self.fiche = fiche
        self.categorie = fiche.categorie
        self.title = fiche.title
        self.materielDressage = fiche.materielDressage
        self.materielSpecifique = fiche.materielSpecifique
        self.responsable = fiche.responsable
        self.nbCouverts = fiche.nbCouverts
        //self.etapes = fiche.etapes
        //self.quantite = fiche.quantite
        self.fiche.delegate = self
    }
    

   //Ajouter une recette dans la base de données 
    func addData(title : String, categorie : CategorieRecette.RawValue, responsable : String, materielDressage : String? , materielSpecifique : String? , nbCouverts : Int){
        db.collection("fiche").addDocument(data: ["title" : title, "categorie" : categorie, "responsable" : responsable, "nbCouverts" : nbCouverts, "materielDressage": materielDressage ?? "Pas de matériels de dressage", "materielSpecifique" : materielSpecifique ?? "Pas de matériels spécifiques"])
        
    }
    
    //Modification des détails de la recette dans la base de données
    func UpdateData(){
        
    }
    
    
}


