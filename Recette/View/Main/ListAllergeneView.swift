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
    
    @State var searchingFor = ""
    var results : [Allergene]{
        if searchingFor.isEmpty{
            return listAllergene.listAllergene.listAllergene
        }
        else{
            return listAllergene.listAllergene.listAllergene.filter{
                $0.libelle.contains(searchingFor)
            }
        }
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
            EditButton()
            }

        }
    }


struct ListAllergeneView_Previews: PreviewProvider {
    static var previews: some View {
        let all = Allergene(libelle: "First Allergene", idAllergene: "1 ")
        let all2 = Allergene(libelle: "Second Allergene", idAllergene: "2 ")
        ListAllergeneView(listAllergene: ListAllergeneViewModel(from : ListAllergene(listAllergene: [all, all2]) ))
    }
}
