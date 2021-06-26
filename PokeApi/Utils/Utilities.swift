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
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimension(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .lightGray
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
    }
    
}
