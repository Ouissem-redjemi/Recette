//
//  ListAllergeneViewModel.swift
//  Recette
//
//  Created by Souhaila kesbi on 24/02/2022.
//

import Foundation
import FirebaseFirestore

class ListAllergeneViewModel : ObservableObject {
    var listAllergene : ListAllergene
    init(from listAllergene : ListAllergene){
        self.listAllergene = listAllergene
    }
    
    func getData (){
            //Get a reference to the database
            let db = Firestore.firestore()
            
            //Get the document of the table fiche
            db.collection("Allergène").getDocuments { snapshot, error in
                //Verify errors
                if error == nil {
                    //NO errors
                    if let snapshot = snapshot{
                        //Get all documents and create list of Recipes
                        self.listAllergene.listAllergene = snapshot.documents.map { doc in
                            return Allergene(idAllergene: doc.documentID,libelle: doc["libelle"]as? String ?? "")
                        }
                        print(self.listAllergene.listAllergene)
                        
                    }
                }else{
                //Handle errors
                    
            }
        }
    
    }
}
