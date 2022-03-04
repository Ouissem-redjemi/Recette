//
//  AllergeneFormView.swift
//  Recette
//
//  Created by Souhaila kesbi on 01/03/2022.
//
import SwiftUI

struct AllergeneFormView: View {
    
    @State private var libelle : String = ""
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Nom de l'allergène")){
                    TextField("Nom  de l'allergène ", text : $libelle)
    
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        
                    }label : {
                        Label("Cancel", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                    }
                }
                
                ToolbarItem{
                    Button{
                        
                    }label : {
                        Label("Don", systemImage: "checkmark")
                            .labelStyle(.iconOnly)
                    }
                }
            })
            
            .navigationTitle("Nouvel Allergene")
            .navigationBarTitleDisplayMode(.inline).font(.body)
        }
    }
    }


/*struct AllergeneFormView_Previews: PreviewProvider {
    static var previews: some View {
        AllergeneFormView()
    }
}*/
