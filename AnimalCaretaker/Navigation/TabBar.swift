//
//  CustomTabBarController.swift
//  AnimalCaretaker
//
//  Created by Владимир on 07.09.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationController = CustomNavigationController(rootViewController: MainVC())
        viewControllers = [navigationController, NewImageVC(), ProfileVC()]
        
        configure()
    }
    
    private func configure() {
        self.tabBar.backgroundColor = .background
        self.tabBar.barTintColor = .background
        
        
        tabBar.items![0].image = UIImage(systemName: "newspaper")
        tabBar.items![1].image = UIImage(systemName: "plus.circle")!.withRenderingMode(.automatic)
        tabBar.items![2].image = UIImage(systemName: "person.crop.circle")!.withRenderingMode(.automatic)

        
    }
    

}
