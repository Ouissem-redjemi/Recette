//
//  ListAllergeneViewModel.swift
//  Recette
//
//  Created by Souhaila kesbi on 24/02/2022.
//

import Foundation
import FirebaseFirestore

class ListAllergeneViewModel : ObservableObject {
    var listAllergene : ListAllergene
    init(from listAllergene : ListAllergene){
        self.listAllergene = listAllergene
    }
    

}
