//
//  CategoriesListView.swift
//  Recette
//
//  Created by Souhaila kesbi on 03/03/2022.
//

import SwiftUI

struct CategoriesListView : View {
    @State var selectedCategorie : CategorieIngredient
    var body : some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing : 30 ){
                ForEach(CategorieIngredient.allCases, id: \.self){ categorie in
                    VStack{
                        Text(categorie.rawValue)
                            .foregroundColor(categorie == selectedCategorie ? .black : .gray)
                        if selectedCategorie == categorie{
                            Capsule()
                                .fill(.black)
                                .frame(height: 3)
                                .padding(.horizontal, -10)
                            
                        }else{
                            Capsule()
                                .fill(.clear)
                                .frame(height: 3)
                                .padding(.horizontal, -10)
                        }
                    }
                    .onTapGesture{
                        self.selectedCategorie = categorie
                    }
                }
            }
        }
    }
}
