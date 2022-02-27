//
//  ListStockViewModel.swift
//  Recette
//
//  Created by Souhaila kesbi on 27/02/2022.
//

import Foundation
import FirebaseFirestore


class ListStockViewModel : ObservableObject {
    var listStock : ListStock
    init(from listStock : ListStock){
        self.listStock = listStock
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
                            return Stock(idStock: doc.documentID,ingredient_stock: doc["ingredients_stock"] as? Ingredient ?? Ingredient(idIngredient: doc.documentID, allergene: doc["allergene"] as? Allergene ?? Allergene.init(idAllergene: "", libelle: "") , categorie: CategorieIngredient(rawValue: doc["categorie"] as? String ?? "") ?? CategorieIngredient.fruit, code: doc["code"] as? Int ?? 0, libelle: doc["libelle"]as? String ?? "", prix_unitaire: doc["prix_unitaire"] as? Double ?? 0 , unite: doc["unite"] as? String ?? ""), quantite :  doc["quantite_stock"] as? Double ?? 0 )
                        }
                        print(self.listStock.listStock)
                        
                    }
                }else{
                //Handle errors
                    
            }
        }
    
    }
}
