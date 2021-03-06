//
//  ContentView.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginVM : LoginViewModel
    var body: some View {
        NavigationView{
            
            
            if loginVM.logIn{
                TabView {
                    HomeView().navigationViewStyle(.stack)
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                    
                        .tabItem {
                            Label("Fiches", systemImage: "heart.text.square")
                        }
                    
                    ListIngredientView()
                        .tabItem {
                            Label("Ingredients", systemImage: "scroll")
                        }
                    ListAllergeneView()
                        .tabItem {
                            Label("Allergènes", systemImage: "a.circle")
                        }
                    
                    VenteView()
                        .tabItem {
                            Label("Ventes", systemImage: "cart.badge.plus")
                        }
                }.accentColor(.purple)
                
                
            }else{
                LoginView()
            }
            
            
            
        }
    }
    
    
    
}
