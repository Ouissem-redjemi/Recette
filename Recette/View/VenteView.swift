//
//  VenteView.swift
//  Recette
//
//  Created by Souhaila kesbi on 04/03/2022.
//

import SwiftUI

struct VenteView: View {
    
    @ObservedObject var listFiches = ListeFicheViewModel ()
    var intent : FicheIntent = FicheIntent ()
  
    @State var quantite :  Int = 0
    
    @State private var selection : Fiche = Fiche(id: "String", categorie: CategorieRecette.accompagnement, title: "Test vente",responsable: "String", nbCouverts: 2, etapes: ["String"])
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()
 
    
    init(){
        self.listFiches.getData()
        self.intent.addObserver(viewModel: listFiches)
    }
    
    var body: some View {
        VStack{
            Text("Vente").font(.title).foregroundColor(.purple)
            Form{
          
                
                Text("Selectionner une fiche pour la vente ").font(.title3)
                
                
                Section(header: Text("Fiches ")){
                    Picker("Fiches : ", selection: $selection) {
                        ForEach(listFiches.listeFiches,id :\.self) {
                            if($0.title != ""){
                                Text($0.title)
                            }
                      }
                    }.pickerStyle(.menu)
                }
                
                Section(header: Text("Info sur la fiche")){
                Text("Cette recette est calculé pour : \(selection.nbCouverts)   " )
               
                }
                
                Text("Selectionner le nombre de fois de cette recette" )
                Section(header: Text("Nombre de plat")){
                    TextField("Quantité", value: $quantite, formatter : formatter)
                }
            
                HStack{
                    Button(action: {
                   //mettre la fonction pour voir la disponibilité en recuperant la fiche et la quantité
                    print("modif demandé")
                    }) {
                        Label(
                            title: {
                                Text(" Valider ")
                                    .fontWeight(.bold)
                                    .font(.system(size: 15))
                                    .frame(alignment: .center)
                                    .padding()
                                    
                            },
                            icon : {
                                Image(systemName: "checkmark.circle").font(.title).foregroundColor(.purple)
                            }
                        
                        
                        ).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purple, lineWidth: 2)
                        )}
                }.frame(alignment : .center)
           
                
                
                    
                    
                    //Text("\(listFiches.listeFiches[0].responsable  )")
                   // Text(Picker.label)
       
   
            
            }
      
        }.navigationBarHidden(true)
    }
}

struct VenteView_Previews: PreviewProvider {
    static var previews: some View {
        VenteView()
    }
}
