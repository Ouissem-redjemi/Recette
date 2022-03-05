//
//  CategorieHomeView.swift
//  Recette
//
//  Created by Souhaila kesbi on 04/03/2022.
//

import SwiftUI

struct CategorieFiche: View {
    //var categorieName : String
    @ObservedObject var listIngredients = ListeFicheViewModel ()
    var intent : FicheIntent = FicheIntent ()
  
    
    init(){
       // self.categorieName = categoryName
        self.listIngredients.getData()
        self.intent.addObserver(viewModel: listIngredients)
        
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                List{
                    ForEach(CategorieRecette.allValues,id :\.self) { categorie in
                        DisclosureGroup(categorie.rawValue) {
                            
                            VStack(alignment: .leading){
                            
                                ScrollView(.vertical, showsIndicators: false){
                                    VStack(alignment: .leading){
                                        ForEach(listIngredients.listeFiches , id: \.id){
                                            ingredient in
                                            if (ingredient.categorie.rawValue == categorie.rawValue){
                                                NavigationLink(destination: DetailFicheView(recette: FicheViewModel(from:  ingredient), listeRecette: listIngredients)){
                                                    if(ingredient.title != ""){
                                                        Text(ingredient.title)
                                                    }
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
         
            }
            
        }


         
    }
}

