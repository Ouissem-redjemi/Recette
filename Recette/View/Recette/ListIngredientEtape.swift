//
//  ListIngredientEtape.swift
//  Recette
//
//  Created by Dalia Rdjm on 6/3/2022.
//

import SwiftUI

struct ListIngredientEtape: View {
    @State var isChecked = false
    @State var qtite = 0
    @ObservedObject var listIngredients = ListeIngredientViewModel ()
    var intent : IngredientIntent = IngredientIntent ()
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()
    
    init(){
        self.listIngredients.getData()
        self.intent.addObserver(viewModel: listIngredients)
    }
    var body: some View {
        VStack{
            List(){
                ForEach(listIngredients.listeIngredient){ ingredient in
                    HStack{
                        Button(action : {
                            self.isChecked.toggle()
                        }, label: {
                            Image(systemName: isChecked ? "checkmark.circle" : "circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.purple)
                        }).padding()
                        Text(ingredient.libelle)
                        if isChecked == true {
                            DisclosureGroup(
                                content: {
                                    Text("Quantité (\(ingredient.unite)) : ")
                                    TextField("Quantité", value: $qtite, formatter: formatter)
                                    
                                
                            }, label: {
                                
                        })
                        }
                    }
                }
                    
            }
        }
    }
}



struct ListIngredientEtape_Previews: PreviewProvider {
    static var previews: some View {
        ListIngredientEtape()
    }
}
