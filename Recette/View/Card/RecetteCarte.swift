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
        AsyncImage(url: URL(string: ""))
    }
}

/*struct RecetteCarte_Previews: PreviewProvider {
    static var previews: some View {
        RecetteCarte(recette: , listRecette: <#ListeFicheViewModel#>)
    }
}*/
