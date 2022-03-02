//
//  ListIngredients.swift
//  Recette
//
//  Created by Souhaila kesbi on 23/02/2022.
//
import SwiftUI

struct ListIngredientView : View {
    @ObservedObject var listIngredients = ListeIngredientViewModel ()
    var intent : IngredientIntent = IngredientIntent ()
  
    
    init(){
        self.listIngredients.getData()
        self.intent.addObserver(viewModel: listIngredients)
    }
    
    @State var searchingFor = ""
    var results : [Ingredient]{
        if searchingFor.isEmpty{
            return listIngredients.listeIngredient
        }
        else{
            return listIngredients.listeIngredient.filter{
                $0.libelle.contains(searchingFor) || $0.allergene.rawValue.contains(searchingFor)
            }
        }
    }
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView{
            VStack{
               Text("Mes Ingredients").bold().font(.title).foregroundColor(Color.blue)
                
                    HStack{
                        
                        Button("Ajouter") { showingSheet.toggle() }.foregroundColor(Color.white).cornerRadius(100).background(Color.green).frame(width: 100,alignment: .center )
                            .sheet(isPresented: $showingSheet) { IngredientFormView(ingredient: IngredientViewModel(from: Ingredient(id: "")), listIngredient: ListeIngredientViewModel())
                            }
                
                        
                }
                    TabView{
                
                            ForEach(listIngredients.listeIngredient , id: \.idIngredient){
                                ingredient in
                                NavigationLink(destination: IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listIngredients )){
                                    
                                    IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listIngredients)
                                }
                            }
                    }
                    .tabViewStyle((PageTabViewStyle()))
                    .onAppear(){
                        self.listIngredients.fetchData()
                        print("Liste ingredient mis a jour ")
                    }
            }    .navigationBarHidden(true)
           
        }
    }
}

struct ListIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        ListIngredientView()
    }
}
