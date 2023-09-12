//
//  CustomNavigationController.swift
//  AnimalCaretaker
//
//  Created by Владимир on 07.09.2023.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    let animalType = UIButton()
    
    
    init(_ frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        
    }
    
    

}


extension CustomNavigationController: UIContextMenuInteractionDelegate {
    
    private func addButton() {
        let button = UIButton(type: .system)
        button.setTitle("Открыть меню", for: .normal)
        button.frame = CGRect(x: 50, y: 200, width: 200, height: 50)
        self.
        view.addSubview(button)
        
        // Добавляем интеракцию для отображения контекстного меню
        let contextMenuInteraction = UIContextMenuInteraction(delegate: self)
        button.addInteraction(contextMenuInteraction)
    }
    
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let option1 = UIAction(title: "Опция 1") { _ in
                print("Выбрана Опция 1")
            }
            let option2 = UIAction(title: "Опция 2") { _ in
                print("Выбрана Опция 2")
            }
            return UIMenu(title: "Меню", children: [option1, option2])
        }
        
        return configuration
    }
}
