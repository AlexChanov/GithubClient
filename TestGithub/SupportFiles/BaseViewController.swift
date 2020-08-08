//
//  BaseViewController.swift
//  TestGithub
//
//  Created by Алексей Чанов on 08.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    public func showAlert(title: String, message:String){
        let alertController = UIAlertController(title: title, message:
        message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
