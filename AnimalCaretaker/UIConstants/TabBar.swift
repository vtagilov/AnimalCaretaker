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
        
        let navigationController = CustomNavigationController(rootViewController: MainTableVC())
        viewControllers = [navigationController, NewImageVC(), ProfileVC()]
        
        
        configure()
    }
    
    private func configure() {
        self.tabBar.backgroundColor = .black
        self.tabBar.barTintColor = .black
        
        
        tabBar.items![0].image = UIImage(systemName: "newspaper")
        tabBar.items![1].image = UIImage(systemName: "plus.circle")!.withRenderingMode(.automatic)
        tabBar.items![2].image = UIImage(systemName: "heart")!.withRenderingMode(.automatic)

        
        
    }
    


}
