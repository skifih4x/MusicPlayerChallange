//
//  Nib.swift
//  MusicPlayerChallange
//
//  Created by Артем Орлов on 07.10.2022.
//

import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
