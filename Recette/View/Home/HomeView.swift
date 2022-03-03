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
       // NavigationView{
        VStack (){
            HStack{
                Button(action:{}){
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.black)
                    
                }
                Spacer()
                Button(action :{
                    self.loginVM.logOut()
                    
                }){
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title)
                }
            }.padding([.vertical,.bottom])
                .padding(.top,10)
            ScrollView (.vertical, showsIndicators: true){
                VStack{
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
                    ScrollView(.vertical, showsIndicators: true){
                            ListFicheView()
                    }.padding(.vertical)
              
                }
               

               
            }
            BarrePlus()
           
    }.background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
       // }.navigationViewStyle(.stack)
}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
