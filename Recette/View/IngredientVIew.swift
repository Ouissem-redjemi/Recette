//
//  IngredientVIew.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import SwiftUI

struct IngredientView: View {
    var body: some View {
        VStack{
            Text("Adnane le meilleur ingrédient")
                .bold()

            
        }.navigationTitle("Adnane zzin")
        
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}
