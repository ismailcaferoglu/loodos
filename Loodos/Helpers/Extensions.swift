//
//  Extensions.swift
//  Loodos
//
//  Created by İsmail Caferoğlu on 29.06.2020.
//  Copyright © 2020 İsmail Caferoğlu. All rights reserved.
//

import UIKit

extension UITextField {
    
    var leftPadding: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    func setAttributedPlaceholder(text:String!, color:UIColor = .gray, fontSize:CGFloat = 16) {
        let attributes:[NSAttributedString.Key : Any] = [ NSAttributedString.Key.foregroundColor: color,
                                                          NSAttributedString.Key.font : UIFont(name: "AvenirNext-Medium", size: fontSize)! ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
}

extension UIView {
    
    func addSubviews(_ views: UIView...){
        views.forEach({ view in
            self.addSubview(view)
        })
    }
}

extension Array {
    
  public subscript(safe index: Int) -> Element? {
       guard startIndex <= index && index < endIndex else {
           return nil
       }
       return self[index]
   }
}
