//
//  CategorieHomeView.swift
//  Recette
//
//  Created by Souhaila kesbi on 04/03/2022.
//

import SwiftUI

struct CategorieHomeView: View {

    var body: some View {
        NavigationView{
            
            List{
                
                ForEach(CategorieIngredient.allValues,id :\.self) { categorie in
                    DisclosureGroup(categorie.rawValue) {
                    CategorieRow(categoryName: categorie.rawValue)
                
                
                }.listStyle(InsetGroupedListStyle())
                
            }
            }
        }.navigationTitle("Categories")
    }
}

struct CategorieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieHomeView()
    }
}
