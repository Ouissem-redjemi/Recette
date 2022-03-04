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
                HomeView()
                    .navigationViewStyle(.stack)
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }else{
                LoginView()
            }
        
            
            /*NavigationLink ( destination: HomeView()){
            VStack{
                Text("Liste des recettes disponibles ")
                    .padding()
            }
            }
            
            NavigationLink ( destination: ListIngredientView()){
            VStack{
                Text("Liste des ingredient disponibles ")
                    .padding()
            }
            }*/
        }.onAppear {
            self.loginVM.logIn = self.loginVM.isLoggedIn
        }

       
        
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
