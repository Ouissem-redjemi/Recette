
//  IngredientVIew.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import SwiftUI


struct IngredientView: View {
    
    @ObservedObject var ingredient : IngredientViewModel
    @ObservedObject var listeingredient: ListeIngredientViewModel
    var intent : IngredientIntent
    
    init(ingredient : IngredientViewModel, listeingredient : ListeIngredientViewModel){
        self.ingredient = ingredient
        self.listeingredient = listeingredient
        self.intent = IngredientIntent()
        self.intent.addObserver(viewModel: ingredient)
        self.intent.addObserver(viewModel: listeingredient)
    }
    
    @State private var isAminating : Bool = false
    
    var body: some View{
  
        ZStack{
            VStack(spacing: 10){
                Spacer()
                Text("\(ingredient.libelle)")
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color.purple, radius: 2, x: 2, y: 2)
                  
                //TODO DANS UN MODAL POUR MODIFICATION
                /* TextField("title", text: $recette.title).onSubmit {
                    intent.intentToChange(title: recette.title )
                }                       */
                Text("Allergene  : \(ingredient.allergene.rawValue)")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,50)
                    .frame(maxWidth : 480)
                Text("Catégorie: \(ingredient.categorie!.rawValue)")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,50)
                    .frame(maxWidth : 480)
                Text("Code: \(ingredient.code)")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,50)
                    .frame(maxWidth : 480)
                Text("Prix Unitaire: \(ingredient.prix_unitaire)")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,50)
                    .frame(maxWidth : 480)
                Text("Unite: \(ingredient.unite)")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,50)
                    .frame(maxWidth : 480)
                Spacer().frame( height:20)
                Group {
                        Button(action: {
                        print("Hello button tapped!")
                    }) {
                        Text("Modifier")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    Spacer().frame( height:10)
                        Button(action: {
                            print("Hello button tapped!")
                    }) {
                        Text("Supprimer")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }
                    
                }
                Spacer()
                

            }.onAppear {
                withAnimation(.easeOut(duration : 1)){
                    isAminating = true
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0 , alignment: .center)

        }
        .frame(alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal,20)
        .padding(.vertical, 20)
     
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        let ing = Ingredient(idIngredient: "", allergene: Allergene.arachide, categorie: CategorieIngredient.fruit, code: "2", libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        
        IngredientView(ingredient: IngredientViewModel(from: ing), listeingredient: ListeIngredientViewModel())
    }
}
