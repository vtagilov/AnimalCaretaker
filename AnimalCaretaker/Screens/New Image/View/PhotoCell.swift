//
//  PhotoCell.swift
//  AnimalCaretaker
//
//  Created by Владимир on 21.10.2023.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PhotoCollectionViewCell"
    
    let imageView = UIImageView()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureCell(_ image: UIImage) {
        imageView.image = image
    }
    
    func configureCameraCell() {
        let image = UIImage(systemName: "camera")!
        imageView.tintColor = .lightGray
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
    
    
    private func configureUI() {
        imageView.contentMode = .bottom
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
}



//MARK: - set constraints
extension PhotoCell {
    private func configureConstraints() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
