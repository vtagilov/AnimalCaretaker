//
//  NavController.swift
//  AnimalCaretaker
//
//  Created by Владимир on 08.09.2023.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.backgroundColor = .none
        self.navigationBar.barTintColor = .none
        self.navigationBar.alpha = 1.0
        
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        navigationBar.alpha = 1.0
        
        title = "Anigram"
        navigationBar
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CustomNavigationController: UINavigationControllerDelegate {
    
}
