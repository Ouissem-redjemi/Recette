
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
            VStack(spacing: 10){
                Spacer()
                Text("\(ingredient.libelle)")
                    .foregroundColor(Color.white)
                    .font(.title3)
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
                Text("Catégorie: \(ingredient.categorie.rawValue)")
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

                Group {
                    
                    
                    
                        Button(action: {
                            self.isModifyViewPresented = true
                        print("modif demandé")
                        }) {
                            Label(
                                title: {
                                    Text("Modifier")
                                        .fontWeight(.bold)
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding()
                                        
                                },
                                icon : {
                                    Image(systemName: "square.and.pencil").font(.title).foregroundColor(.white)
                                }
                            
                            
                            ).overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                       
                    
                    }.sheet(isPresented: $isModifyViewPresented, content: {
                        ModificationIngredientView(ingredient: self.ingredient, listIngredient: self.listeingredient)})
       
                        Button(action: {
                            self.isRemovePresented.toggle()
                            print("suppression demandé")
                    }) {
                        HStack{
                            Image(systemName: "trash").font(.title).foregroundColor(.white)
                            Text("Supprimer")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                
                            
                        }.overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                      
                    }
                    .actionSheet(isPresented: $isRemovePresented){
                        ActionSheet(title: Text("Are you sure ?"),buttons: [
                                        .destructive(Text("Supprimer l'ingredient"), action: {
                                            self.ingredient.removeData()
                                            self.mode.wrappedValue.dismiss()
                                            print("Suppression réussie")
                                        }),
                                            .cancel()
                                    ])
                        }
                    }
                Spacer()
                }
            
            .onAppear {
                withAnimation(.easeOut(duration : 1)){
                    isAminating = true
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0 , alignment: .center)

            }
        .frame(alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [ Color.purple,Color.blue]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal,20)
        .padding(.vertical, 20)
     
        }
    }


struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(ingredient: IngredientViewModel(from: Ingredient(id: "id")), listeingredient: ListeIngredientViewModel())
    }
}
