//
//  UIColor.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let pokemonMain = UIColor.rgb(red: 227, green: 53, blue: 12)
    static let pokemonLabel = UIColor.rgb(red: 49, green: 49, blue: 49)
}
