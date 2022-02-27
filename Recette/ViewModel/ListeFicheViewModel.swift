//
//  ListeFicheViewModel.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import Combine
import FirebaseFirestore

class ListeFicheViewModel: ObservableObject, Subscriber {
    
    //Subscriber Functions
    func receive(subscription: Subscription) {
       subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }
    func receive(_ input: FicheIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
       switch input{
          case .ready:
             break
       case .titleChanging(_):
           break
       case .responsableChanging(_):
           break
       case .matSpeChanging(_):
           break
       case .matDressChanging(_):
          break
       case .couvertChanging(_):
           break
        case .listUpdated:
           self.objectWillChange.send()
           
          
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    
    typealias Input = FicheIntentState
    
    typealias Failure = Never
    
    
    
    @Published var listeFiches = [Fiche] ()
  
    
    //Data Functions
    //Get Data from Firestore
   func getData (){
        //Get a reference to the database
        let db = Firestore.firestore()
        
        //Get the document of the table fiche
        db.collection("fiche").getDocuments { snapshot, error in
            //Verify errors
            if error == nil {
                //NO errors
                if let snapshot = snapshot{
                    //Get all documents and create list of Recipes
                    self.listeFiches = snapshot.documents.map { doc in
                        return Fiche(id: doc.documentID, categorie: doc["categorie"] as? CategorieRecette ?? CategorieRecette.dessert, title: doc["title"] as? String ?? "", materielDressage: doc["materielDressage"]as? String ?? "", materielSpecifique: doc["materielSpecifique"]as? String ?? "", responsable: doc["responsable"] as? String ?? "" , nbCouverts: doc["nbCouverts"] as? Int ?? 0)
                    }
                    print(self.listeFiches.description)
                    
                }
            }else{
            //Handle errors
                
        }
    }
        
        //Add Data to FireStore
        func addData(){
            //Reference database
            let db = Firestore.firestore()
            
            //Add Recipe to Database
            
            
        }
    
   
    
 
    
}
}
