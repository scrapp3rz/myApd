//
//  PhotoController.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var Segment: UISegmentedControl!
    @IBOutlet weak var CollectionView: UICollectionView!

    var nextButton: UIBarButtonItem?
    var choosenImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        let cameraNib = UINib(nibName: CAMERA_CELL, bundle: nil)
        let libraryNib = UINib(nibName: LIBRAIRIE_CELL, bundle: nil)
        CollectionView.register(cameraNib, forCellWithReuseIdentifier: CAMERA_CELL)
        CollectionView.register(libraryNib, forCellWithReuseIdentifier: LIBRAIRIE_CELL)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showButtonNext()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Segment.numberOfSegments
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Segment.numberOfSegments
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if Segment.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CAMERA_CELL, for: indexPath) as! CameraCell
            cell.setupCamera(controller: self)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LIBRAIRIE_CELL, for: indexPath) as! LibrairieCell
            cell.setup(controller: self)
            return cell
        }
    }
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    

    func takePhotoAndNext(image: UIImage) {
        let controller = fxController()
        controller.image = image
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    @IBAction func Segment_Choosen(_ sender: Any) {
        let indexPath = IndexPath(item: Segment.selectedSegmentIndex, section: 0)
        CollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        showButtonNext()
    }
    
    func showButtonNext() {
        if Segment.selectedSegmentIndex == 1 {
            nextButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(nextOne))
            navigationItem.rightBarButtonItem = nextButton
        } else {
            if nextButton != nil {
                nextButton = nil
                navigationItem.rightBarButtonItem = nil
            }
        }
    }

    @objc func nextOne() {
        if choosenImage != nil {
            let newController = ResizerController()
            newController.image = choosenImage!
            navigationController?.pushViewController(newController, animated: true)
        }
      
    }
    

}

