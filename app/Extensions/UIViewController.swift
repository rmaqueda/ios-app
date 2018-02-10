//
//  UIViewController.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

extension UIViewController {
    var TAG : String {
        return String(describing: type(of: self))
    }
    
    public func print(_ items: Any...){
        let output = items.map { "\($0)" }.joined(separator: " ")
        Swift.print(TAG + ":", output)
    }
}
