//
//  HomeView.swift
//  Recette
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var loginVM : LoginViewModel
    //Barre de recherche
    @State var search : String = ""
    var searchFiche : [Fiche] {
        if search.isEmpty{
            return listFiches.listeFiches
        }else{
            return listFiches.SearchFicheByName(title: search)
        }
    }
    @ObservedObject var listFiches = ListeFicheViewModel ()
    var intent : FicheIntent = FicheIntent()
    init(){
        self.listFiches.getData()
        self.intent.addObserver(viewModel: listFiches)
    }
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
                            BarrePlus(recette: FicheViewModel(from: Fiche(id: "")), listRecette: self.listFiches)
                            Spacer()
                            
                            //bouton de deconnexion
                            Button(action :{
                                self.loginVM.logOut()
                                
                            }){
                                Image(systemName: "iphone.and.arrow.forward")
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
                
                
            }.navigationBarHidden(true)
        }
        
        
    }
}

/*struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}*/
