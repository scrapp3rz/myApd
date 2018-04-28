//
//  LibrairieCell.swift
//  AppMyDelight
//
//  Created by vincent portier on 23/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import Photos

let LIBRAIRIE_CELL = "LibrairieCell"


class LibrairieCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var controller: PhotoController?
    var images = [UIImage]()
    var assets = [PHAsset]()
    

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(controller: PhotoController) {
        self.controller = controller
        CollectionView.delegate = self
        CollectionView.dataSource = self
        let nib = UINib(nibName: SQUARE_IMAGE_CELL, bundle: nil)
        CollectionView.register(nib, forCellWithReuseIdentifier: SQUARE_IMAGE_CELL)
        getPhotos()
        let statut = PHPhotoLibrary.authorizationStatus()
        if statut == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.getPhotos()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: SQUARE_IMAGE_CELL, for: indexPath) as! SquareImageCell
        cell.ImageView.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let taille = frame.size.width / 4
        return CGSize(width: taille, height: taille)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func fetchOptions() -> PHFetchOptions {
        let fetchOption = PHFetchOptions()
        fetchOption.fetchLimit = 70
        let sorting = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOption.sortDescriptors = [sorting]
        return fetchOption
    }
    
    
    func getPhotos() {
        let allMyAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions())
        DispatchQueue.global(qos: .background).async {
            allMyAssets.enumerateObjects({ (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let size = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let myImage = image {
                        self.images.append(myImage)
                        self.assets.append(asset)
                    }
                    if count == allMyAssets.count - 1 {
                        DispatchQueue.main.async {
                            if self.images.count > 0 {
                                self.recupImage(image: self.images[0])
                            }
                            self.CollectionView.reloadData()
                        }
                    }
                })
            })
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        recupImage(image: images[indexPath.row])
    }
    
    func recupImage(image: UIImage) {
        ImageView.image = image
        controller?.choosenImage = image
        if let choosenImage = images.index(of: image) {
            let choosenAsset = assets[choosenImage]
            let options = PHImageRequestOptions()
            options.isSynchronous = false
            options.isNetworkAccessAllowed = true
            options.deliveryMode = .opportunistic
            options.version = .current
            options.resizeMode = .exact
            options.progressHandler = {(progress, error, stop, info) in
            }
            PHCachingImageManager().requestImageData(for: choosenAsset, options: options) { (data, string, orientation, info) in
                if let imageData = data, let newImage = UIImage(data: imageData) {
                    self.ImageView.image = newImage
                    self.controller?.choosenImage = newImage
                }
            }
        }
    }
    
    
    
/*
        var controller: PhotoController?
        var images = [UIImage]()
        var assets = [PHAsset]()
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        func setup(controller: PhotoController) {
            self.controller = controller
            CollectionView.delegate = self
            CollectionView.dataSource = self
            let nib = UINib(nibName: SQUARE_IMAGE_VIEW_CELL, bundle: nil)
            CollectionView.register(nib, forCellWithReuseIdentifier: SQUARE_IMAGE_VIEW_CELL)
            getPhotos()
            let statut = PHPhotoLibrary.authorizationStatus()
            if statut == .notDetermined {
                PHPhotoLibrary.requestAuthorization ({ (status ) in
                    if status == .authorized {
                        self.getPhotos()
                    }
                })
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SQUARE_IMAGE_VIEW_CELL, for: indexPath) as! SquareImageViewCell
            cell.ImageView.image = images[indexPath.row]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = frame.size.width / 6
            return CGSize(width: size, height: size)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
            
        }
        
        
        func fetchOptions() -> PHFetchOptions{
            let fetchOption = PHFetchOptions()
            fetchOption.fetchLimit = 100
            let sorting = NSSortDescriptor(key: "creationDate", ascending: false)
            fetchOption.sortDescriptors = [sorting]
            return fetchOption
        }
        
        func getPhotos() {
            let allAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions())
            DispatchQueue.global(qos: .background).async {
                allAssets.enumerateObjects({ (asset, count, stop) in
                    let imageManager = PHImageManager.default()
                    let size = CGSize(width: 200, height: 200)
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
                    imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                        
                        if let myImage = image {
                            self.images.append(myImage)
                            self.assets.append(asset)
                        }
                        
                        if count == allAssets.count - 1 {
                            DispatchQueue.main.async {
                                if self.images.count > 0 {
                                    self.getImage(image: self.images[0])
                                }
                                self.CollectionView.reloadData()
                            }
                        }
                    })
                })
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            getImage(image: images[indexPath.row])
        }
        
        
        func getImage(image: UIImage) {
            ImageView.image = image
            controller?.choosenImage = image
            if let choosenimage = images.index(of: image) {
                let pickedAsset = assets[choosenimage]
                let options = PHImageRequestOptions()
                options.isSynchronous = false
                options.isNetworkAccessAllowed = true
                options.deliveryMode = .opportunistic
                options.version = .current
                options.resizeMode = .exact
                options.progressHandler = {(Progress, error, stop, info) in
                    PHCachingImageManager().requestImageData(for: pickedAsset, options: options, resultHandler: { (data, string, orientation, info) in
                        if let imageData = data, let newImage = UIImage(data: imageData) {
                            self.ImageView.image = newImage
                            self.controller?.choosenImage = newImage
                        }
                    })
                }
                
            }
            
            
            
        }
        
   */
        
}
