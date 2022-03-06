//
//  FicheViewModel.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FicheDelegate{
    func change(categorie : CategorieRecette)
    func change(title : String)
    func change(materielDressage : String?)
    func change(materielSpecifique : String?)
    func change(responsable : String)
    func change(nbCouverts : Int)
    func change(etapes : [String])
    func change(ingredients :[String : Double])
        
}

class FicheViewModel : FicheDelegate , ObservableObject, Subscriber{
    typealias Input = FicheIntentState
    
    typealias Failure = Never
    
    
    public var fiche : Fiche
    //Get a reference to the database
    private var db = Firestore.firestore()
    
    @DocumentID var idFiche : String?
    @Published var categorie : CategorieRecette
    @Published var title : String
    @Published var materielDressage : String?
    @Published var materielSpecifique : String?
    @Published var responsable : String
    @Published var nbCouverts : Int
    @Published var ingredients : [String : Double]?
    @Published var etapes : [String]
    @Published var description : String?
    @Published var duree : Int?
    @Published var titleStep : String?
    @Published var cout : Double?
    func change(categorie: CategorieRecette) {
        self.categorie = categorie
    }
    
    func change(title: String) {
        self.title = title
    }
    
    func change(materielDressage: String?) {
        self.materielDressage = materielDressage
    }
    
    func change(materielSpecifique: String?) {
        self.materielSpecifique = materielSpecifique
    }
    
    func change(responsable: String) {
        self.responsable = responsable
    }
    
    func change(nbCouverts: Int) {
        self.nbCouverts = nbCouverts
    }
    
    func change(etapes : [String]){
        self.etapes = etapes
    }
    
    func change(ingredients : [String : Double] ){
        self.ingredients = ingredients
    }
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited) // unlimited : on veut recevoir toutes les valeurs
    }
    
    // au cas où le publisher déclare qu'il finit d'émetter : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }

     // Activée à chaque send() du publisher :
    func receive(_ input: FicheIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
       switch input{
          case .ready:
             break
          case .titleChanging(let title):
           self.fiche.title = title
       case .responsableChanging(let responsable):
           self.fiche.responsable = responsable
       case .matSpeChanging(let materielSpecifique):
           self.fiche.materielSpecifique = materielSpecifique
       case .matDressChanging(let materielDressage):
           self.fiche.materielDressage = materielDressage
       case .couvertChanging(let couvert):
           self.fiche.nbCouverts = Int(couvert)
        case .listUpdated:
           break
           
          
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    
    func affichage_Dico( listingredients : ListeIngredientViewModel, recette : FicheViewModel, listeRecette : ListeFicheViewModel) -> [String]{
        var libelle : [String] = [""]
        for idE in recette.etapes {
               for fiche in listeRecette.listeFiches{
                   if idE == fiche.idFiche{
                       print(idE)
                       libelle = affichage_suite(fiche: fiche, listIngredients: listingredients)
                       print(libelle)
                    }
                }
        }
        return libelle
    }
        

    func affichage_suite(fiche : Fiche, listIngredients : ListeIngredientViewModel)-> [String] {
        var libelle : [String] = [""]
        
  
        print("title\(fiche.titleStep!)")
        for (cle) in fiche.ingredients!.keys {
            print(fiche.ingredients!.keys.description)
            
            for ingredient in listIngredients.listeIngredient.indices {
                print("interieur fir ")
                if cle == listIngredients.listeIngredient[ingredient].idIngredient{
                    libelle.append( listIngredients.listeIngredient[ingredient].libelle)
                    print( listIngredients.listeIngredient[ingredient].libelle)
                }
                else{
                    print("else")
                }
            }
 
        }

        return libelle
    }
        

    func coutRecette(fiche : Fiche ,listIngredient : ListeIngredientViewModel, listeRecette : ListeFicheViewModel) -> Double {
        var somme : Double = 0

        
        for (cle,valeur) in fiche.ingredients! {
            print("coucou cle ")
            for ingredient in listIngredient.listeIngredient{
                print("coucou i,grediet ")
                if cle == ingredient.idIngredient{
                    print("coucou if ")
                    somme += ingredient.prix_unitaire * Double(valeur)
                    print(somme)
                }
            }
        }
        return  somme * 1.05
    }
    
    
    
    func recuperationEtapes(listrecette : ListeFicheViewModel, fiche : FicheViewModel) -> [Fiche]{
        var tabEtape : [Fiche] = []
        
        for idE in fiche.etapes {
               for fiche in listrecette.listeFiches{
                   if idE == fiche.idFiche{
                       print(idE)
                       tabEtape.append(fiche)
                       print(tabEtape.description)
                    }
                }
        }
        return tabEtape
    }
    
    func recuperationIngredient(etapes : [Fiche]) -> [String]{
        var libelle : [String] = [""]
        
        for etape in etapes{
            for (cle) in etape.ingredients!.keys {
                print(etape.ingredients!.keys.description)
                libelle.append(cle)
                
     
            }

        }
        return libelle
    }
    
    func recuperationLibelleIngredient(keyIngredient : [String], listIngredient : ListeIngredientViewModel ) -> [String]{
        var titleing : [String] = []
        
        for title in keyIngredient{
            for ingredient in listIngredient.listeIngredient{
                print("coucou i,grediet ")
                if title == ingredient.idIngredient{
                    titleing.append(ingredient.libelle)
                }
            }
        }
        return titleing
    }
    
    
    
    
    
    
    
  /*public var coutSimple : Double{
        var total : Double = 0
        for idS in etapes{
            for (idIng , qte ) in ingredients!{
                total = total + ingredient.prix_unitaire * qte
            }
        }
        return total
    }*/

    
    init(from fiche : Fiche){
        self.fiche = fiche
        self.idFiche = fiche.idFiche
        self.categorie = fiche.categorie
        self.title = fiche.title
        self.materielDressage = fiche.materielDressage
        self.materielSpecifique = fiche.materielSpecifique
        self.responsable = fiche.responsable
        self.nbCouverts = fiche.nbCouverts
        self.etapes = fiche.etapes
        self.duree = fiche.duree
        self.description = fiche.description
        self.titleStep = fiche.titleStep
        self.ingredients = fiche.ingredients
        self.cout = fiche.cout
        self.fiche.delegate = self
    }
    

   //Ajouter une recette dans la base de données
    func addData(title : String, categorie : CategorieRecette.RawValue, responsable : String, materielDressage : String? , materielSpecifique : String? , nbCouverts : Int, etapes : Array<String>){
         db.collection("fiche").addDocument(data: ["title" : title, "categorie" : categorie, "responsable" : responsable, "nbCouverts" : nbCouverts, "materielDressage": materielDressage ?? "Pas de matériels de dressage", "materielSpecifique" : materielSpecifique ?? "Pas de matériels spécifiques", "etapes": etapes])
    }
    
    //Ajouter une étape dans la base de données
    func addDataStep(title : String?, description : String?, duree : Int?, ingredients : [String:Double]?) -> String{
        let idStep = db.collection("fiche").addDocument(data: ["titleStep" : title ?? "", "description": description ?? "", "duree" : duree ?? "", "ingredients" : ingredients ?? ["" : 0]]).documentID
        return idStep
    }
    
    //Ajouter une étape dans la liste des étapes
    func addStep(id : String){
        print("AVANT")
       
            self.etapes.append(id)
        
        print("APRES")
        for id in etapes{
            print("\(id)")
        }
        
    }
    
    //Modification des détails de la recette dans la base de données
    func UpdateData(recette : FicheViewModel){
        if let docId = recette.fiche.idFiche {
           db.collection("fiche").document(docId).updateData([
                   "title": recette.title,
                   "materielDressage": recette.materielDressage ?? "Pas de matériels de dressage",
                   "materielSpecifique": recette.materielSpecifique ?? "Pas de matériels spécifiques",
                   "nbCouverts": recette.nbCouverts,
                   "responsable": recette.responsable,
                   "categorie": recette.categorie.rawValue,
                   "description": recette.description ?? ""
                ])
            }
        }
    
    
    
    //Remove a recipe from the list of recipes
    func removeData(){
        if let docId = fiche.idFiche{
            db.collection("fiche").document(docId).delete{
                error in
                if let error = error {
                    print("L'erreur est : \(error.localizedDescription)")
                }
            }
        }
    }
}


