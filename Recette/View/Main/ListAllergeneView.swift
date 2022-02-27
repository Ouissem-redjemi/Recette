//
//  ListAllergeneView.swift
//  Recette
//
//  Created by Souhaila kesbi on 24/02/2022.
//

import SwiftUI

struct ListAllergeneView: View {
    
    @ObservedObject var listAllergene : ListAllergeneViewModel
    
    init(listAllergene : ListAllergeneViewModel){
        self.listAllergene = listAllergene
        listAllergene.getData()
    }
    
    var body: some View {
        VStack (){
            Text("Mes Allergènes").bold()
                List {
            
                    ForEach(listAllergene.listAllergene.listAllergene , id: \.idAllergene){
                        allergene  in
                            VStack(alignment: .leading){
                                Group{
                                    Text(allergene.libelle).bold()
                                }
                            }
                        }
                    .onDelete{ indexSet in
                        listAllergene.listAllergene.listAllergene.remove(atOffsets: indexSet)
                        
                    }.onMove{ indexSet, index in
                        listAllergene.listAllergene.listAllergene.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
            }
            EditButton()
        }
    }


struct ListAllergeneView_Previews: PreviewProvider {
    static var previews: some View {
        var all = Allergene(idAllergene: "1 ", libelle: "First Allergene")
        var all2 = Allergene(idAllergene: "2 ", libelle: "Second Allergene")
        ListAllergeneView(listAllergene: ListAllergeneViewModel(from : ListAllergene(listAllergene: [all, all2]) ))
    }
}
