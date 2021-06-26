//
//  Utilities.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit

class Utilities {
    let sectionInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    let itemsPerRow: CGFloat = 2
    
    
    static func changeID(pokemonId: Int) -> String {
        if pokemonId < 10 {
            return "00\(pokemonId)"
        } else if pokemonId < 100 {
            return "0\(pokemonId)"
        } else {
            return "\(pokemonId)"
        }
    }
    
}
