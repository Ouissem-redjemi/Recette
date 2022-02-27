//
//  HomeView.swift
//  Recette
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct HomeView: View {

    
    var body: some View {
        VStack{
            HStack{
                Button(action:{}){
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.black)
                    
                }
                Spacer()
                Button(action :{}){
                    Image("")
                        .renderingMode(.original)
                }
            }.padding([.horizontal,.bottom])
                .padding(.top,10)
            ScrollView (.vertical, showsIndicators: false){
                VStack (spacing : 15){
                    HStack (spacing : 10){
                        Image()
                    }
                }
            }
            NavigationView{
                ScrollView{
                    ListFicheView()
                }
            }.navigationViewStyle(.stack).navigationTitle("Mes Recettes")
    }.background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
    
}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
