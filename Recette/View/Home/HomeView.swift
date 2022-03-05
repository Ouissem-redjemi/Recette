//
//  HomeView.swift
//  Recette
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var loginVM : LoginViewModel
    @State var search : String = ""
    var body: some View {
    NavigationView{
        ScrollView (.vertical, showsIndicators: true){
            ZStack{
                VStack{
                    HStack{
                        //classement des fiches par catégories
                        NavigationLink(destination: CategorieFiche()){
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        //ajout d'une fiche
                        BarrePlus()
                        Spacer()
                        
                        //bouton de deconnexion
                        Button(action :{
                            self.loginVM.logOut()
                            
                        }){
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.gray)
                                .font(.title)
                        }
                    }
                    .padding([.vertical,.top])
                    .padding(.top,5)
               
                    HStack(spacing: 15){
                        HStack (spacing : 10){
                            Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            TextField("Rechercher une recette", text: $search)
                            }.padding()
                                .background(.black.opacity(0.06))
                                .cornerRadius(15)
                            Button(action:{}){
                                Image(systemName: "line.horizontal.3.circle")
                                    .font(.title)
                                    .foregroundColor(.black)}
                            }.padding(.horizontal)
                    HStack{
                        Text("Mes recettes")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }.padding()
                    
            
                            ListFicheView()

              
                }.background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
                   

                   
                }
     
    
            }
         }//.navigationViewStyle(.stack)
        
        
    }
}

/*struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}*/
