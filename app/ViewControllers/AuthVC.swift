//
//  AuthVC.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

class AuthVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
}
