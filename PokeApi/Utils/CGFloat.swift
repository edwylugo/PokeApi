//
//  CGFloat.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
