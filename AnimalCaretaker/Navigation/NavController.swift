//
//  NavController.swift
//  AnimalCaretaker
//
//  Created by Владимир on 08.09.2023.
//

import UIKit

class CustomNavigationController: UINavigationController {

    var backButton = UIBarButtonItem()
    let titleLabel = UILabel()
    var selectionButton: PullDownButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstarints()
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)
        self.navigationBar.topItem?.backBarButtonItem = backButton
        navigationBar.topItem?.setLeftBarButton(backButton, animated: true)
        navigationBar.topItem?.leftBarButtonItem?.tintColor = .white
        viewController.navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            UIView.animate(withDuration: 0.3) {
                viewController.navigationController?.isNavigationBarHidden = false
            }
            
        })
    }
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if viewControllers.first is ProfileVC {
            let vc = viewControllers.first as! ProfileVC
            UIView.animate(withDuration: 0.3) {
                vc.segmentControl.alpha = 1.0
                vc.profileInfo.alpha = 1.0
                vc.tableView.alpha = 1.0
            }
            self.isNavigationBarHidden = true
        }
        if viewControllers.first is MainVC {
            let vc = viewControllers.first as! MainVC
            UIView.animate(withDuration: 0.3) {
                vc.tableView.alpha = 1.0
            }
        }
        if viewControllers.first is NewImageVC {
            let vc = viewControllers.first as! NewImageVC
            UIView.animate(withDuration: 0.3) {
                vc.collectionView.alpha = 1.0
                vc.titleLabel.alpha = 1.0
            }
        }
        return super.popViewController(animated: animated)
    }
    
    
    
    private func configureUI() {
        backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        titleLabel.textAlignment = .left
        titleLabel.text = "gram"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(titleLabel)
        
        selectionButton = PullDownButton({})
        selectionButton.configureButton()
        navigationBar.addSubview(selectionButton)
    }
    
}



//MARK: - set constraints
extension CustomNavigationController {
    
    private func configureConstarints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            selectionButton.rightAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            selectionButton.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            selectionButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
    }
}
