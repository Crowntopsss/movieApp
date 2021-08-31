//
//  File.swift
//  movieApp
//
//  Created by Temitope on 30/08/2021.
//

import UIKit


extension UIView{
    @IBInspectable var conerRadius : CGFloat{
        get{return self.conerRadius}
        set{
            self.layer.cornerRadius = newValue
            
        }
    }
}
