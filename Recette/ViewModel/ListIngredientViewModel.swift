//
//  ListeIngredientViewModel.swift
//  Recette
//
//  Created by Souhaila kesbi on 22/02/2022.
//

import Foundation
import Combine
import FirebaseFirestore

class ListeIngredientViewModel: ObservableObject, Subscriber {
    typealias Input = IngredientIntentState
    
    typealias Failure = Never
    
    @Published var listeIngredient = [Ingredient] ()
    

    
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
         case .listUpdated:
            self.objectWillChange.send()
        }
        return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    func getData (){
            //Get a reference to the database
            let db = Firestore.firestore()
            
            //Get the document of the table fiche
            db.collection("ingredients").getDocuments { snapshot, error in
                //Verify errors
                if error == nil {
                    //NO errors
                    if let snapshot = snapshot{
                        //Get all documents and create list of Recipes
                        self.listeIngredient = snapshot.documents.map { doc in
                            return Ingredient(idIngredient: doc.documentID, allergene: doc["allergene"] as? Allergene ?? Allergene.arachide , categorie: CategorieIngredient(rawValue: doc["categorie"] as? String ?? "") ?? CategorieIngredient.cremerie, code: doc["code"]as? String ?? "", libelle: doc["libelle"]as? String ?? "", prix_unitaire: doc["prix_unitaire"] as? Double ?? 0 , unite: doc["unite"] as? String ?? "")
                        }
                        print("Recuperation des ingredient de la bd ")
                        
                    }
                }else{
                //Handle errors
                    
            }
        }
    
    }
}
