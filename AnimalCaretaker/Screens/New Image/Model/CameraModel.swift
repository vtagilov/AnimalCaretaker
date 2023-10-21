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
    
    
    
    func chooseImageFromGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func getPhotoFromGallery(_ index: Int) {
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        let asset = allPhotos[index]
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: .max, height: .max), contentMode: .aspectFit, options: requestOptions) { (image, _) in
            if let image = image {
                print(image)
            }
        }
    }
    
    
    
    func getAllPhotosFromGallery() {
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        for index in 0..<allPhotos.count {
            let asset = allPhotos[index]
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFit, options: requestOptions) { (image, _) in
                if let image = image {
                    print(index)
                    self.imagesFromGallery.append(image)
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
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            print(pickedImage)
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
