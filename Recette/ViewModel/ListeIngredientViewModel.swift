//
//  ListeIngredientViewModel.swift
//  Recette
//
//  Created by Souhaila kesbi on 22/02/2022.
//

import Foundation
import Combine
import FirebaseFirestore

class ListeIngredientViewModel: ObservableObject, Subscriber{
    typealias Input = IngredientIntentState
    
    typealias Failure = Never
    
    @Published var listeIngredient = [Ingredient] ()
    private var listener : ListenerRegistration?
    let db = Firestore.firestore()
    
    
    //categories correspond à un dictionnaire qui permt de lié chaque cartégorie à sa liste d'ingredients
    
    var categories: [String: [Ingredient]] {
            Dictionary(
                grouping: listeIngredient,
                by: { $0.categorie.rawValue }
            )
        }
    
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }
    
    func receive(_ input: IngredientIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
        switch input{
           case .ready:
              break
           case .libelleChanging(_):
            break
        case .allergeneChanging(_):
            break
        case .categorieChanging(_):
            break
        case .codeChanging(_):
            break
        case .prixUnitaireChanging(_):
            break
        case .uniteChanging(_):
            break
        case .quantiteChanging(_):
            break
    
        case .listUpdated:
            self.objectWillChange.send()
        }
        return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    
    public  func getList() -> [Ingredient]{
        var tab : [Ingredient] = []
        for ingredient in listeIngredient {
            tab.append(ingredient)
        }
        return tab
    }
    func getData (){
            //Get a reference to the database

        
            //Get the document of the table fiche
            db.collection("ingredients").getDocuments { snapshot, error in
                //Verify errors
                if error == nil {
                    //NO errors
                    if let snapshot = snapshot{
                        //Get all documents and create list of Recipes
                        self.listeIngredient = snapshot.documents.map { doc in
                            return Ingredient(id: doc.documentID, allergene: doc["allergene"] as? Allergene ?? Allergene.arachide , categorie: CategorieIngredient(rawValue: doc["categorie"] as? String ?? "") ?? CategorieIngredient.cremerie, code: doc["code"]as? String ?? "", libelle: doc["libelle"]as? String ?? "", prix_unitaire: doc["prix_unitaire"] as? Double ?? 0 , unite: doc["unite"] as? String ?? "", quantite:  doc["quantite"] as? Double ?? 0)
                        }
                        print("Recuperation des ingredient de la bd ")
                        
                    }
                }else{
                //Handle errors
            }
        }
    
    }
    //----------------------- MAJ des listes ingredients   ------------------------------
    func fetchData(){
        print("entree dans la fonction")

           if listener == nil {
               listener = db.collection("ingredients").addSnapshotListener({ (querySnapshot, error) in
                   guard let doc = querySnapshot?.documents else {
                       print("Il n'y a pas de documents")
                       return
                   }
                   self.listeIngredient = doc.map{ (document) -> Ingredient in
                       return Ingredient(id: document.documentID, allergene: Allergene(rawValue: document["allergene"] as? String ?? "") ?? Allergene.aucun , categorie: CategorieIngredient(rawValue: document["categorie"] as? String ?? "") ?? CategorieIngredient.cremerie, code: document["code"]as? String ?? "", libelle: document["libelle"]as? String ?? "", prix_unitaire: document["prix_unitaire"] as? Double ?? 0 , unite: document["unite"] as? String ?? "", quantite: document["quantite"]as? Double ?? 0)
                       
                   }
                   print("Synchronisation des données réussie")
               })
           }
       }
    
   

}
