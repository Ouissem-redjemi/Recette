//
//  RecetteCarte.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct RecetteCarte: View {
    @ObservedObject var listRecette : ListeFicheViewModel
    @ObservedObject var recette : FicheViewModel
    var intent : FicheIntent
    init (recette : FicheViewModel, listRecette : ListeFicheViewModel){
        self.recette = recette
        self.listRecette = listRecette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: recette)
        self.intent.addObserver(viewModel: listRecette)
    }
    var body: some View {
        VStack{
        AsyncImage(url: URL(string: "https://images.vexels.com/media/users/3/231368/isolated/preview/03f100290e37d6f7f5de39d9af357afc-plano-de-utensilios-de-cozinha.png")){
            image in image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(alignment: .top){
                    Text(recette.title)
                        .font(.headline)
                        .foregroundColor(.black)
                        .shadow(color: .gray, radius: 3, x: 0, y: 0)
                        .frame(maxWidth: 136)
                        .padding()
                }
        } placeholder: {
            Image(systemName: "questionmark")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.white.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .bottom){
                    Text(recette.title)
                        .font(.headline)
                        .foregroundColor(.black)
                        .shadow(color: .purple, radius: 3, x: 0, y: 0)
                        .frame(maxWidth: 136)
                    .padding()}
        }
        }.frame(width: 160, height: 155, alignment: .top)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.white)]) , startPoint: .top , endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.gray.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}

struct RecetteCarte_Previews: PreviewProvider {
    static var previews: some View {
        RecetteCarte(recette: FicheViewModel(from: Fiche(id: "FObL0vgRlp2NDdKzmVsp" )) , listRecette: ListeFicheViewModel())
    }
}
