//
//  CameraModel.swift
//  AnimalCaretaker
//
//  Created by Владимир on 21.10.2023.
//

import UIKit
import Photos


extension NewImageVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func takePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func getPhotosFromGallery() {
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        let loadedCount = imagesFromGallery.count
        let willLoadCount = (allPhotos.count > 30 + loadedCount) ? 30 + loadedCount : allPhotos.count
        let startIndex = ( allPhotos.count - loadedCount - willLoadCount ) > 0 ? ( allPhotos.count - loadedCount - willLoadCount ) : 0
        if startIndex + willLoadCount == loadedCount {
            print("all photos loaded")
            return
        }
//        проверить не много ли загружаю
        
        print("update ", startIndex ..< startIndex + willLoadCount)
        for index in startIndex ..< startIndex + willLoadCount {
            let asset = allPhotos[index]
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 1000, height: 1000), contentMode: .aspectFill, options: requestOptions) { (image, _) in
                if let image = image {
                    self.imagesFromGallery.append(image)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        return
    }
    
    
    
    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            getPhotosFromGallery()
            break
        case .denied, .restricted:
            showSettingsAlert()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.getPhotosFromGallery()
                } else {
                    self.showSettingsAlert()
                }
            }
        case .limited:
            getPhotosFromGallery()
        @unknown default:
            break
        }
    }
    
    
    
    func showSettingsAlert() {
        let alert = UIAlertController(title: "Access Denied", message: "This app requires access to your photo library. Please enable access in Settings.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
