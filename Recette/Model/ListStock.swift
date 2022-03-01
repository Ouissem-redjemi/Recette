//
//  ListStock.swift
//  Recette
//
//  Created by Souhaila kesbi on 24/02/2022.
//
import Foundation
struct ListStock{
    
    var listStock = [Stock] ()
    
    mutating func addStock(stock : Stock){
        self.listStock.append(stock)
    }
}
