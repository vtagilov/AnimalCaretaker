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
        self.viewControllers = [
            CustomNavigationController(rootViewController: MainVC()),
            CustomNavigationController(rootViewController: NewImageVC()),
            CustomNavigationController(rootViewController: ProfileVC())
        ]
        configure()
        

    }
    
    private func configure() {
        tabBar.items![0].image = UIImage(systemName: "house")
        tabBar.items![1].image = UIImage(systemName: "plus.circle")!.withRenderingMode(.automatic)
        tabBar.items![2].image = UIImage(systemName: "person.crop.circle")!.withRenderingMode(.automatic)

        tabBar.backgroundColor = UIColor.black
    }
    
}
