//
//  EtiquetteView.swift
//  Recette
//
//  Created by Souhaila kesbi on 05/03/2022.
//

import SwiftUI

struct EtiquetteView: View {
   @ObservedObject var recette : FicheViewModel
    @ObservedObject var listeRecette: ListeFicheViewModel
    @State private var checked = true
    @State var tabLibelle = [String]()
    
    
    @ObservedObject var listIngredients = ListeIngredientViewModel ()
    var intent : FicheIntent
    var intentIngredient : IngredientIntent
    init(recette : FicheViewModel, listeRecette : ListeFicheViewModel){
        self.recette = recette
        self.listeRecette = listeRecette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: recette)
        self.intent.addObserver(viewModel: listeRecette)
        self.intentIngredient = IngredientIntent()
        
        self.listIngredients.getData()
        
    }
    var textView: some View {
        Text("Nom de la fiche \n liste d'ingredients")
     
      }
    
    var body: some View {
     
        
        NavigationView{
            VStack(spacing : 10 ) {
                Text("Nom de la fiche \(recette.fiche.title )")

                
                
                Text("Ingrédients ").underline()
                
                Button {
                    self.tabLibelle = self.recette.recuperationLibelleIngredient(keyIngredient: self.recette.recuperationIngredient(etapes: self.recette.recuperationEtapes(listrecette: listeRecette, fiche: recette)), listIngredient: listIngredients)
                } label: {
                    Text("Afficher")
                }
                
                
                ForEach(tabLibelle , id: \.self){ ingredient in
                    Text("\(ingredient)")
                }
               
                
                
               /* ForEach(0..<recette.etapes.count){ i in
                       ForEach(listeRecette.listeFiches){ fiche in
                           if recette.etapes[i] == fiche.idFiche{
                               if fiche.titleStep!.isEmpty{
                                   Text("\(fiche.title)")
                                   
                               }else{
                                   Button {
                                       self.tabLibelle += affichage_Dico(dico: fiche.ingredients!)
                                   } label: {
                                       Text("Afficher")
                                   }
                                   VStack{
                                    
                                       Text(self.tabLibelle.description)
                                   }

                               }
                        }
                   }
            }*/
                Toggle(isOn: $checked) {
                    Text("Vente").padding()
                }.padding()
                Spacer()
                
 
           
            
        
        }
       
            .navigationBarItems(trailing:
                  Button(action: exportToPDF) {
                       Image(systemName: "square.and.arrow.up")
                   }
        
        )
        }.navigationBarBackButtonHidden(true)
      

    }
    
    /*func affichage_Dico(dico : [String:Double]) -> [String]{
        var libelle : [String] = [""]
        //var quantite : Double
        print(" coucou : \(dico.description)")
        for (cle, valeur) in dico {
            listIngredients.listeIngredient.forEach { ingredient in
                if cle == ingredient.idIngredient{
                    libelle.append(ingredient.libelle)
                    print(ingredient.libelle)
                }
                
            }
            
        }
        print(libelle)
        return libelle
    }*/
    

    func exportToPDF() {
        let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
        let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let rootVC = UIApplication.shared.windows.first?.rootViewController

        //Render the PDF
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
        DispatchQueue.main.async {
            do {
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                    context.beginPage()
                    rootVC?.view.layer.render(in: context.cgContext)
                })
                print("wrote file to: \(outputFileURL.path)")
            } catch {
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    }
    
   
    
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


