
//  IngredientVIew.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import SwiftUI


struct IngredientCategorieView: View {
    
    @ObservedObject var ingredient : IngredientViewModel
    @ObservedObject var listeingredient: ListeIngredientViewModel
    var intent : IngredientIntent
    
    @State var isModifyViewPresented = false
    @State var isRemovePresented = false
    
    init(ingredient : IngredientViewModel, listeingredient : ListeIngredientViewModel){
        self.ingredient = ingredient
        self.listeingredient = listeingredient
        self.intent = IngredientIntent()
        self.intent.addObserver(viewModel: ingredient)
        self.intent.addObserver(viewModel: listeingredient)
    }
    @Environment(\.presentationMode) private var mode
    @State private var isAminating : Bool = false
    
    var body: some View{
  
        ZStack{
            VStack{
                Text("\(ingredient.libelle)")
                    .foregroundColor(Color.white)

                    .fontWeight(.heavy)
                    .shadow(color: Color.purple, radius: 2, x: 2, y: 2)
                Text("Prix Unitaire: \(ingredient.prix_unitaire)").italic()
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,30)
                    .frame(maxWidth : 480)
                    .font(.system(size: 10))
                Text("Quantité :").italic()
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,30)
                    .frame(maxWidth : 480)
                    .font(.system(size: 10))
        
             
          
                 
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0 , alignment: .center)

                }.frame(alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [ Color.purple,Color.blue]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            .padding(.horizontal,40)
            .padding(.vertical, 10)
            
            .onAppear {
                withAnimation(.easeOut(duration : 1)){
                    isAminating = true
                }
            }
            

            }

     
        }
    


struct IngredientCategorieView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCategorieView(ingredient: IngredientViewModel(from: Ingredient(id: "id")), listeingredient: ListeIngredientViewModel())
    }
}
