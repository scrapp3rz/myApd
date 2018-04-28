//
//  CameraCell.swift
//  AppMyDelight
//
//  Created by vincent portier on 22/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import AVFoundation


let CAMERA_CELL = "CameraCell"

class CameraCell: UICollectionViewCell, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var View_Camera: UIView!
    @IBOutlet weak var Flash_Button: UIButton!
    @IBOutlet weak var Rotation_Button: UIButton!
    @IBOutlet weak var Take_Photo: UIButton!
    
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var captureOutput: AVCapturePhotoOutput?
    var position = AVCaptureDevice.Position.front
    var reglages = AVCapturePhotoSettings()
    var flashStatus = FlashStatus.off
    var controller: PhotoController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    
    func setupCamera(controller: PhotoController) {
        self.controller = controller
        self.Flash_Button.isHidden = true
        videoPreviewLayer?.removeFromSuperlayer()
        
        if let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) {
            if camera.hasFlash {
                flash()
                Flash_Button.isHidden = false
            }
            do {
                let input = try AVCaptureDeviceInput(device: camera)
                captureSession = AVCaptureSession()
                if (captureSession?.canAddInput(input))! {
                    captureSession?.addInput(input)
                }
                captureOutput = AVCapturePhotoOutput()
                if (captureSession?.canAddOutput(captureOutput!))! {
                    captureSession?.addOutput(captureOutput!)
                }
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = View_Camera.bounds
                View_Camera.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
            } catch {
                print("Une erreur est survenue")

            }
        }
        
    }
    
    
    
    
    @IBAction func Flash_Button_Action(_ sender: Any) {
        switch flashStatus {
        case .on:
            flashStatus = .off
            Flash_Button.setImage(#imageLiteral(resourceName: "flash-off"), for: .normal)
        case .off:
            flashStatus = .on
            Flash_Button.setImage(#imageLiteral(resourceName: "flash-on"), for: .normal)
        }
        flash()
    }
    
    @IBAction func Rotation_Button_Action(_ sender: Any) {
        if position == .front {
            position = .back
        } else {
            position = .front
        }
        setupCamera(controller: controller!)
    }
    
    
    func flash() {
        switch flashStatus {
        case .on: reglages.flashMode = .on
        case .off: reglages.flashMode = .off
        }
    }
    
    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil, let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else { return }
        controller?.takePhotoAndNext(image: getSquarePhoto(image: image))
    }
    
    func getSquarePhoto(image: UIImage) -> UIImage {
        if let layer = videoPreviewLayer {
            let rectOutput = layer.metadataOutputRectConverted(fromLayerRect: layer.bounds)
            var cgImage = image.cgImage!
            let x = rectOutput.origin.x * CGFloat(cgImage.width)
            let y = rectOutput.origin.y * CGFloat(cgImage.height)
            let width = rectOutput.size.width * CGFloat(cgImage.width)
            let height = rectOutput.size.height * CGFloat(cgImage.height)
            let rectACouper = CGRect(x: x, y: y, width: width, height: height)
            cgImage = cgImage.cropping(to: rectACouper)!
            let imageRect = UIImage(cgImage: cgImage, scale: 1, orientation: image.imageOrientation)
            return imageRect
        } else {
            return image
        }
    }
    
    
    @IBAction func Take_Photo_Action(_ sender: Any) {
        captureOutput?.capturePhoto(with: reglages, delegate: self)
        setupCamera(controller: controller!)
    }
    
    
    
    
    
    
}
