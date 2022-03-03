//
//  CategorieView.swift
//  Recette
//
//  Created by Souhaila kesbi on 02/03/2022.
//

import SwiftUI

struct CategorieView: View {

    //let categorie : CategorieIngredient
    var listeIngredient : ListeIngredientViewModel
    @State private var selectedCategorie : CategorieIngredient = CategorieIngredient.cremerie
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing : 30 ){
                ForEach(CategorieIngredient.allCases, id: \.self){ categorie in
                    VStack{
                        Text(categorie.rawValue)
                            .foregroundColor(categorie == selectedCategorie ? .black : .gray)
           
                            Capsule()
                                .fill(.black)
                                .frame(height: 3)
                                .padding(.horizontal, -10)

                            TabView{
                                    ForEach(listeIngredient.listeIngredient , id: \.id){
                                        ingredient in
                                        if ingredient.categorie.rawValue == categorie{
                                            NavigationLink(destination: IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listeIngredient )){
                                                
                                                IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listeIngredient)
                                            }
                                        }
                                        
                                    }
                                
                            }
                            
                        
                        
                    }
                    .onTapGesture{
                        self.selectedCategorie = categorie
                    }
                }
            }
        }.padding([.top,.horizontal])
        /*
        VStack{
           // CategoriesListView(selectedCategorie: selectedCategorie)
            
            ScrollView(.vertical, showsIndicators: false){
                ForEach(CategorieIngredient.allCases, id:\.self){
                    categorie in
                    
                }.padding(.horizontal)
            }
        }
        
        
        */
        
        /*
        NavigationView{
            List{
                ForEach(CategorieIngredient.allCases){ categorie in
                    NavigationLink{
                        CategorieDetailView(categorie: categorie , listIngredient: listIngredient)
                    } label:{
                        Text(categorie.rawValue)
                    }
                    
                 
                }
            }.navigationTitle("Catégories")
        }.navigationViewStyle(.stack)*/
    }
}
/*
struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        let ing : Ingredient = Ingredient(id: "String", allergene: Allergene.soja, categorie: CategorieIngredient.legume, code: "1", libelle: "mon ingr", prix_unitaire: 2, unite: "kg")
        let ing2 : Ingredient = Ingredient(id: "String", allergene: Allergene.celeri, categorie: CategorieIngredient.legume, code: "1", libelle: "mon ingr", prix_unitaire: 2, unite: "kg")
        let ing3 : Ingredient = Ingredient(id: "String", allergene: Allergene.arachide, categorie: CategorieIngredient.epice, code: "1", libelle: "mon ingr", prix_unitaire: 2, unite: "kg")
        CategorieView(listIngredient: [ing, ing2, ing3])
    }
}
*/
