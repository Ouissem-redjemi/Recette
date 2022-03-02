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
    
    var listStock : ListStock
    
    init(from listStock : ListStock){
        self.listStock = listStock
    }
    
    
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
            let db = Firestore.firestore()
            
            //Get the document of the table fiche
            db.collection("stock").getDocuments { snapshot, error in
                //Verify errors
                if error == nil {
                    //NO errors
                    if let snapshot = snapshot{
                        //Get all documents and create list of Recipes
                        self.listStock.listStock = snapshot.documents.map { doc in
                            return Stock(idStock: doc.documentID,ingredient_stock: doc["ingredients_stock"] as? Ingredient ?? Ingredient(idIngredient: doc.documentID, allergene: doc["allergene"] as? Allergene ?? Allergene.arachide , categorie: CategorieIngredient(rawValue: doc["categorie"] as? String ?? "") ?? CategorieIngredient.fruit, code: doc["code"] as? String ?? "", libelle: doc["libelle"]as? String ?? "", prix_unitaire: doc["prix_unitaire"] as? Double ?? 0 , unite: doc["unite"] as? String ?? ""), quantite :  doc["quantite_stock"] as? Double ?? 0 )
                        }
                        print(self.listStock.listStock)
                        
                    }
                }else{
                //Handle errors
                    
            }
        }
    
    }
}
