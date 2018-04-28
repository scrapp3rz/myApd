//
//  fxController.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import CoreImage

class fxController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    var image: UIImage!
    
    
    var effects = [
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone"
    ]
    
     var images = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.image = image
        CollectionView.delegate = self
        CollectionView.dataSource = self
        let nib = UINib(nibName: SQUARE_IMAGE_CELL, bundle: nil)
        CollectionView.register(nib, forCellWithReuseIdentifier: SQUARE_IMAGE_CELL)
        let suivant = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(nextOne))
        navigationItem.rightBarButtonItem = suivant

    }

    @objc func nextOne() {
        let controller = FinishPostController()
        controller.image = ImageView.image!
        navigationController?.pushViewController(controller, animated: true)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global(qos: .background).async {
            let context = CIContext(options: nil)
            let ciImage = CIImage(image: self.image)
            for filter in self.effects {
                if let filterChoosen = CIFilter(name: filter) {
                    filterChoosen.setDefaults()
                    filterChoosen.setValue(ciImage, forKey: kCIInputImageKey)
                    let filterData = filterChoosen.value(forKey: kCIOutputImageKey) as! CIImage
                    if let cgImage = context.createCGImage(filterData, from: filterData.extent) {
                        let filteredImage = UIImage(cgImage: cgImage, scale: self.image.scale, orientation: self.image.imageOrientation)
                        DispatchQueue.main.async {
                            self.images.append(filteredImage)
                            self.CollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SQUARE_IMAGE_CELL, for: indexPath) as! SquareImageCell
        cell.ImageView.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CollectionView.frame.height / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        self.ImageView.image = image
    }
    
}
