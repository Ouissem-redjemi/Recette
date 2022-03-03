//
//  LoginViewModel.swift
//  Recette
//
//  Created by Dalia Rdjm on 3/3/2022.
//

import Foundation
import FirebaseAuth
import SwiftUI

class LoginViewModel : ObservableObject {
    let auth = Auth.auth()
    @Published var logIn = false
    var isLoggedIn : Bool {
        //Retourne True si l'utilisateur courant est connecté
        // Si currentUser == nil , on aura False ce qui signifie que le user n'est pas connecté
        return auth.currentUser != nil
        
    }
    //Pour la connexion avec un email et mdp unique
    func logIn(email : String, mdp : String){
        auth.signIn(withEmail: email, password: mdp) { authDataResult, error in
            if authDataResult != nil, error == nil {
                //Utilisateur connecté
                self.logIn = true
                
                print("User connecté --- Victoire!")
            }else {
                print("Connexion Impossible à cause : \(error!.localizedDescription)")
                return
            }
        }
    }
    
    //Deconnexion de l'utilisateur
    func logOut(){
        do{
            try auth.signOut()
            self.logIn = false
            print("Deconnexion réussie ----- Victoire!")
        } catch{
            print("Deconnexion Impossible")
        }
        
    }
}
