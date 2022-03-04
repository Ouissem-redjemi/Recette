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
    //Get a reference to the database
    private var db = Firestore.firestore()
    private var listener : ListenerRegistration?
    
    //Data Functions
    //Get Data from Firestore
   func getData (){
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
                    print("On a récupérer toutes les recettes de Firestore")
                    
                }
            }else{
            //Handle errors
                
        }
    }
   }
    
    //Get Step from dataBase
    
   
        //Synchronize Recipe
    func fetchData(){
           if listener == nil {
               listener = db.collection("fiche").addSnapshotListener({ (querySnapshot, error) in
                   guard let doc = querySnapshot?.documents else {
                       print("Il n'y a pas de documents")
                       return
                   }
                   self.listeFiches = doc.map{ (document) -> Fiche in
                       return Fiche(id: document.documentID, categorie: document["categorie"] as? CategorieRecette ?? CategorieRecette.dessert, title: document["title"] as? String ?? "", materielDressage: document["materielDressage"]as? String ?? "", materielSpecifique: document["materielSpecifique"]as? String ?? "", responsable: document["responsable"] as? String ?? "" , nbCouverts: document["nbCouverts"] as? Int ?? 0, etapes: document["etapes"] as? [String] ?? [])
                       
                   }
                   print("Synchronisation des données réussie")
               })
           }
       }
    func printt(variable : String){
        print(variable)
    }
    
    
   
    
 
    
}

