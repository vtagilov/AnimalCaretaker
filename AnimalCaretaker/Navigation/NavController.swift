//
//  NavController.swift
//  AnimalCaretaker
//
//  Created by Владимир on 08.09.2023.
//

import UIKit

class CustomNavigationController: UINavigationController {

    let backButton = UIBarButtonItem()
    let titleLabel = UILabel()
    var selectionButton: PullDownButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureUI()
        configureConstarints()
    }
    
    
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        super.pushViewController(viewController, animated: animated)
//        backButton.isHidden = false
//    }
    
    
    private func configureNavBar() {
        
        self.navigationBar.backgroundColor = .background
        self.navigationBar.barTintColor = .background
        self.navigationBar.alpha = 1.0
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.alpha = 1.0
    }
    
    
    private func configureUI() {
//        backButton.addTarget(self, action: #selector(backButtonWasTapped), for: .touchUpInside)
//        backButton.isHidden = true
//        backButton.setImage(UIImage(systemName: ""), for: .normal)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        backButton.title = "asd"
//        print(self.navigationBar.backItem)
//        self.navigationItem.backBarButtonItem = backButton
//        navigationBar.addSubview(backButton)

        let customBackButton = UIBarButtonItem(title: "asd", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = customBackButton
        navigationBar.backItem?.setLeftBarButton(customBackButton, animated: true)
        self.navigationItem.backButtonTitle = "asd1"
        print(self.navigationItem.backBarButtonItem)
        
        titleLabel.textAlignment = .left
        titleLabel.text = "gram"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(titleLabel)
        
        selectionButton = PullDownButton({
            print("asdasdad")
        })
        selectionButton.configureButton()
        navigationBar.addSubview(selectionButton)
        
    }


    private func configureConstarints() {
        NSLayoutConstraint.activate([
//            backButton.leftAnchor.constraint(equalTo: self.navigationBar.leftAnchor),
//            backButton.widthAnchor.constraint(equalToConstant: 50),
//            backButton.topAnchor.constraint(equalTo: self.navigationBar.topAnchor),
//            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leftAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            selectionButton.rightAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            selectionButton.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            selectionButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
    }
    
    
    
    @objc private func backButtonWasTapped() {
        self.popViewController(animated: true)
        print("backButtonWasTapped")
        if self.viewControllers.count == 1 {
//            backButton.isHidden = true
        }
        
    }
    

}
