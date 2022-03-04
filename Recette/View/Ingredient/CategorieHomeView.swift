//
//  CategorieHomeView.swift
//  Recette
//
//  Created by Souhaila kesbi on 04/03/2022.
//

import SwiftUI

struct CategorieHomeView: View {
    //var categorieName : String
    @ObservedObject var listIngredients = ListeIngredientViewModel ()
    var intent : IngredientIntent = IngredientIntent ()
  
    
    init(){
       // self.categorieName = categoryName
        self.listIngredients.getData()
        self.intent.addObserver(viewModel: listIngredients)
        
    }
    
    var body: some View {
        
        NavigationView{
            
            List{
                
                ForEach(CategorieIngredient.allValues,id :\.self) { categorie in
                    DisclosureGroup(categorie.rawValue) {
                        
                        VStack(alignment: .leading){
                        
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    ForEach(listIngredients.listeIngredient , id: \.id){
                                        ingredient in
                                        if(ingredient.categorie.rawValue == categorie.rawValue){
                                            NavigationLink(destination: IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listIngredients )){
                                                
                                            IngredientCategorieView(ingredient: IngredientViewModel(from: ingredient), listeingredient: ListeIngredientViewModel())
                                            }
                                        }
                                        
                                        
                                    }
                                }
                            }
                        }
                
                
                }
                
            }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Categories")
                //.navigationBarHidden(true)
                .navigationViewStyle(.stack)
               // .navigationBarBackButtonHidden(true)
        }
    }
}

