//
//  ListStockViewModel.swift
//  Recette
//
//  Created by Souhaila kesbi on 27/02/2022.
//

import Foundation
import FirebaseFirestore
import Combine

class ListStockViewModel : ObservableObject, Subscriber {
    
    typealias Input = StockIntentState
    
    typealias Failure = Never
    
    @Published var listStock = [Stock] ()
    
    private var listener : ListenerRegistration?
    let db = Firestore.firestore()
    func receive(subscription: Subscription) {
       subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }
    
    func receive(_ input: StockIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
        switch input{
           case .ready:
            break
           case .ingredient_stockChanging(_):
            break
           case .quantite_stockChanging(_):
            break
           case .listUpdated:
            self.objectWillChange.send()
        }
        return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    
    func getData (){
            //Get a reference to the database

            
            //Get the document of the table fiche
            db.collection("stock").getDocuments { snapshot, error in
                //Verify errors
                if error == nil {
                    //NO errors
                    if let snapshot = snapshot{
                        //Get all documents and create list of Recipes
                        self.listStock = snapshot.documents.map { doc in
                            return Stock(id: doc.documentID,ingredient_stock: doc["ingredients_stock"] as? Ingredient ?? Ingredient(id: doc.documentID , allergene: doc["allergene"] as? Allergene ?? Allergene.arachide , categorie: CategorieIngredient(rawValue: doc["categorie"] as? String ?? "") ?? CategorieIngredient.fruit, code: doc["code"] as? String ?? "", libelle: doc["libelle"]as? String ?? "", prix_unitaire: doc["prix_unitaire"] as? Double ?? 0 , unite: doc["unite"] as? String ?? ""), quantite :  doc["quantite_stock"] as? Double ?? 0 )
                        }
                        print("Recuperation du stock de la bd")
                        
                    }
                }else{
                //Handle errors
                    
            }
        }
    
    }
    
    
    func fetchData(){
           if listener == nil {
               listener = db.collection("stock").addSnapshotListener({ (querySnapshot, error) in
                   guard let doc = querySnapshot?.documents else {
                       print("Il n'y a pas de documents")
                       return
                   }
                   self.listStock = doc.map { (document) -> Stock in
                       return Stock(id: document.documentID,ingredient_stock: document["ingredients_stock"] as? Ingredient ?? Ingredient(id: document.documentID, allergene: document["allergene"] as? Allergene ?? Allergene.arachide , categorie: CategorieIngredient(rawValue: document["categorie"] as? String ?? "") ?? CategorieIngredient.fruit, code: document["code"] as? String ?? "", libelle: document["libelle"]as? String ?? "", prix_unitaire: document["prix_unitaire"] as? Double ?? 0 , unite: document["unite"] as? String ?? ""), quantite :  document["quantite_stock"] as? Double ?? 0 )
                   }
                   print("Synchronisation des données réussie")
               })
           }
       }
    
       //Remove a recipe from the list of recipes
       func removeData(atOffsets index : IndexSet){
           let list = index.lazy.map{self.listStock[$0]}
           list.forEach{ recipe in
               if let docId = recipe.idStock {
                   db.collection("stock").document(docId).delete{
                       error in
                       if let error = error{
                           print("Une erreur \(error.localizedDescription) est survenue dans la suppression du stock")
                       }
                   }
               }
               
           }
       }
    
    
    
    
    
    
}
