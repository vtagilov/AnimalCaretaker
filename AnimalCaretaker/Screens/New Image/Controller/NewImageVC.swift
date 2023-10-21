//
//  NewImageVC.swift
//  AnimalCaretaker
//
//  Created by Владимир on 07.09.2023.
//

import UIKit
import Photos


class NewImageVC: UIViewController {
    
    let titleLabel = UILabel.makeTitleLabel("New Post")
    let chooseFromGallefyButton = UIButton()
    let makePhotoButton = UIButton()
    
    let imageView = UIImageView()
    
    var imagesFromGallery = [UIImage]()
    
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPhotoLibraryAccess()
        confugureUI()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    private func confugureUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}



//MARK: - configure Constraints
extension NewImageVC {
    private func configureConstraints() {
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}



//MARK: - UICollectionView Delegate & DataSource
extension NewImageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return imagesFromGallery.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        if indexPath.section == 0 {
            cell.configureCell(UIImage(systemName: "camera")!)
            cell.configureCameraCell()
            return cell
        }
        cell.configureCell(imagesFromGallery[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width - 10, height: view.frame.width / 3 - 10)
        }
        return CGSize(width: view.frame.width / 3 - 10, height: view.frame.width / 3 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            takePhoto()
            return
        }
        
        let image = getPhotoFromGallery(indexPath.row)
        self.navigationController?.pushViewController(OneImageVC(image), animated: true)
        UIView.animate(withDuration: 0.2) {
            collectionView.alpha = 0.0
            self.titleLabel.alpha = 0.0
        }
    }
    
    
}


