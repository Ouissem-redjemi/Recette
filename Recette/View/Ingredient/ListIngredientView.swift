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
    
            ZStack{
                NavigationView{
                VStack{
                    HStack{
                        Text("Mes Ingredients").padding(.horizontal).foregroundColor(Color.purple)
                            .font(.largeTitle.bold())
                            .shadow(color: Color.purple, radius: 10, x: 10, y: 10)
                    }
                      
                    TabView{
                            ForEach(listIngredients.listeIngredient , id: \.id){
                                ingredient in
                                NavigationLink(destination: IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listIngredients )){
                                    
                                    IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listIngredients)
                                }
                            }
                        
                    }
                    .tabViewStyle((PageTabViewStyle()))
                    .toolbar(content: {
                        ToolbarItem(){
                            Button(action: {
                                    showingSheet.toggle()
                                }){
                                    Image(systemName: "plus.app").font(.title) .foregroundColor(.purple)
                                }.sheet(isPresented: $showingSheet) { IngredientFormView(ingredient: IngredientViewModel(from: Ingredient(id: "")), listIngredient: ListeIngredientViewModel())
                                }
                        }
                     
                        ToolbarItem(placement:.navigationBarLeading){
                            NavigationLink (destination: CategorieHomeView().navigationViewStyle(.stack)
                                                .navigationBarTitle("")){
                                Image(systemName: "list.triangle").font(.title) .foregroundColor(.purple)

                            }
                        }
               
                    })
                }
                .onAppear{
                    self.listIngredients.fetchData()
                    print("Liste ingredient mis a jour ")
                }
                    //.navigationBarHidden(true)
                        .navigationViewStyle(.stack)
                        .navigationBarTitle("")
                        .navigationBarBackButtonHidden(true)
                    
            }
        
          
        }
       
        
    }
    
    
    
}





