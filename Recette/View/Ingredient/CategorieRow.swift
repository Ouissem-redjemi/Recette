//
//  CategorieRow.swift
//  Recette
//
//  Created by Souhaila kesbi on 04/03/2022.
//

import SwiftUI

struct CategorieRow: View {
    var categorieName : String
    @ObservedObject var listIngredients = ListeIngredientViewModel ()
    var intent : IngredientIntent = IngredientIntent ()
  
    
    init(categoryName: String){
        self.categorieName = categoryName
        self.listIngredients.getData()
        self.intent.addObserver(viewModel: listIngredients)
        
    }
    
    var body: some View {
      
        VStack(alignment: .leading){
        
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(listIngredients.listeIngredient , id: \.id){
                        ingredient in
                        if(ingredient.categorie.rawValue == categorieName){
                            IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: ListeIngredientViewModel())
                        }
                        
                        
                    }
                }
            }
        }
    }
}

