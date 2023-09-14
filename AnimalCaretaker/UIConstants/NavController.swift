//
//  NavController.swift
//  AnimalCaretaker
//
//  Created by Владимир on 08.09.2023.
//

import UIKit

class CustomNavigationController: UINavigationController {

    let backButton = UIButton()
    let titleLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureUI()
        configureConstarints()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        backButton.isHidden = false
    }
    
    private func configureNavBar() {
        self.navigationBar.backgroundColor = .none
        self.navigationBar.barTintColor = .none
        self.navigationBar.alpha = 1.0
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.alpha = 1.0
    }
    
    
    private func configureUI() {
        backButton.addTarget(self, action: #selector(backButtonWasTapped), for: .touchUpInside)
        backButton.isHidden = true
        backButton.setImage(UIImage(systemName: ""), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(backButton)
        
        
        titleLabel.text = "Anigram"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(titleLabel)
        
        
    }
    
    
    private func configureConstarints() {
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: self.navigationBar.leftAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.topAnchor.constraint(equalTo: self.navigationBar.topAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.navigationBar.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor)
        ])
    }
    
    
    
    @objc private func backButtonWasTapped() {
        self.popViewController(animated: true)
        if self.viewControllers.count == 1 {
            backButton.isHidden = true
        }
        
    }
    

}
