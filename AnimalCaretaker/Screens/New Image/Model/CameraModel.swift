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
    
    
    
    func getPhotoFromGallery(_ index: Int) -> UIImage {
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        let asset = allPhotos[index]
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.resizeMode = .exact
        var image = UIImage()
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 1000, height: 1000), contentMode: .aspectFit, options: requestOptions) { (foundImage, _) in
            if let foundImage = foundImage {
                image = foundImage
            }
        }
        return image
    }
    
    
    
    func getAllPhotosFromGallery() {
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        for index in 0..<allPhotos.count {
            let asset = allPhotos[index]
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 1000, height: 1000), contentMode: .aspectFit, options: requestOptions) { (image, _) in
                if let image = image {
                    self.imagesFromGallery.append(image)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    
    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            getAllPhotosFromGallery()
            break
        case .denied, .restricted:
            showSettingsAlert()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.getAllPhotosFromGallery()
                } else {
                    self.showSettingsAlert()
                }
            }
        case .limited:
            getAllPhotosFromGallery()
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
