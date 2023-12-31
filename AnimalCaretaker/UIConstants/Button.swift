//
//  Button.swift
//  AnimalCaretaker
//
//  Created by Владимир on 22.09.2023.
//

import Foundation
import UIKit


extension UIButton {
    static func makeLikeButton() -> UIButton {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.tintColor = .white
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        return button
    }
}


class PullDownButton: UIView {
    
    private let button = UIButton()
    
    let buttonAction: () -> Void?

    init(_ buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureButton() {
        let dogAction = UIAction(title: "Dogs") { [weak self] _ in
            guard let self = self else { return }
            button.setTitle("Dogs", for: .normal)
            buttonAction()
        }
        let catAction = UIAction(title: "Cats") { [weak self] _ in
            guard let self = self else { return }
            button.setTitle("Cats", for: .normal)
            buttonAction()
        }
        
        button.setTitleColor(.white, for: .disabled)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.setTitle("Dogs", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = .boldSystemFont(ofSize: 32)
        button.menu = UIMenu(children: [catAction, dogAction])
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        configureConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: button.leftAnchor),
            self.rightAnchor.constraint(equalTo: button.rightAnchor),
            self.topAnchor.constraint(equalTo: button.topAnchor),
            self.bottomAnchor.constraint(equalTo: button.bottomAnchor)
        ])
    }
    
}
