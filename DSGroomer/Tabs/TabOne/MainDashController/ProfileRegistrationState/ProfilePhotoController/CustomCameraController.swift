//
//  CustomCameraController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/16/21.
//

import Foundation
import UIKit
import AVFoundation
import MobileCoreServices
import Photos

class CustomPhotoController : UIViewController {
    
    var captureSession : AVCaptureSession!
    var frontCamera : AVCaptureDevice!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .times), for: .normal)
        cbf.titleLabel?.tintColor = dsRedColor
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var cameraSwapButtonButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .undoAlt), for: .normal)
        cbf.titleLabel?.tintColor = dsFlatBlack
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var profileImageview : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.contentMode = .scaleAspectFill
        cbf.layer.borderColor = coreOrangeColor.cgColor
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 70, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .lock), for: .normal)
        cbf.clipsToBounds = true
        cbf.imageView?.contentMode = .scaleAspectFill
        cbf.contentMode = .scaleAspectFill
        
        return cbf
        
    }()
    
    let lookingGoodLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Lookin’ good! Please make\nsure your face is fully visible"
        thl.font = UIFont(name: dsHeaderFont, size: 14)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreOrangeColor
        thl.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        thl.layer.masksToBounds = true
        return thl
        
    }()
    
    lazy var takePhotoButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreWhiteColor
        cbf.layer.masksToBounds = true
        cbf.layer.borderColor = coreOrangeColor.cgColor
        cbf.layer.borderWidth = 12
        cbf.addTarget(self, action: #selector(self.handleTakePhotoButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var retakePhotoButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.masksToBounds = true
        cbf.layer.borderColor = coreOrangeColor.cgColor
        cbf.layer.borderWidth = 12
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .pencilAlt), for: .normal)
        cbf.setTitleColor(coreWhiteColor, for: .normal)
        cbf.tintColor = coreWhiteColor
        cbf.layer.borderWidth = 2
        cbf.layer.borderColor = coreWhiteColor.cgColor
        cbf.isHidden = true
        cbf.addTarget(self, action: #selector(self.handleRetakePhotoButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.checkForGalleryAuth()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.captureSession.stopRunning()
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.cameraSwapButtonButton)
        self.view.addSubview(self.profileImageview)
        self.view.addSubview(self.lookingGoodLabel)
        self.view.addSubview(self.takePhotoButton)
        self.view.addSubview(self.retakePhotoButton)

        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.cameraSwapButtonButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64).isActive = true
        self.cameraSwapButtonButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -18).isActive = true
        self.cameraSwapButtonButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.cameraSwapButtonButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.profileImageview.topAnchor.constraint(equalTo: self.cameraSwapButtonButton.bottomAnchor, constant: 74).isActive = true
        self.profileImageview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.profileImageview.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.3).isActive = true
        self.profileImageview.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.3).isActive = true
        
        let width = (UIScreen.main.bounds.width / 1.3)
        self.profileImageview.layer.cornerRadius = width / 2
        
        self.lookingGoodLabel.topAnchor.constraint(equalTo: self.profileImageview.bottomAnchor, constant: 43).isActive = true
        self.lookingGoodLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.lookingGoodLabel.heightAnchor.constraint(equalToConstant: 59).isActive = true
        self.lookingGoodLabel.widthAnchor.constraint(equalToConstant: 257).isActive = true
        self.lookingGoodLabel.layer.cornerRadius = 59/2
        
        self.takePhotoButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        self.takePhotoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.takePhotoButton.heightAnchor.constraint(equalToConstant: 78).isActive = true
        self.takePhotoButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        self.takePhotoButton.layer.cornerRadius = 78/2
        
        self.retakePhotoButton.centerXAnchor.constraint(equalTo: self.profileImageview.rightAnchor, constant: 0).isActive = true
        self.retakePhotoButton.centerYAnchor.constraint(equalTo: self.profileImageview.centerYAnchor, constant: 0).isActive = true
        self.retakePhotoButton.heightAnchor.constraint(equalToConstant: 49).isActive = true
        self.retakePhotoButton.widthAnchor.constraint(equalToConstant: 49).isActive = true
        self.retakePhotoButton.layer.cornerRadius = 49/2

    }
    
    @objc func handleTakePhotoButton() {
        self.takeLiveViewPhoto()
    }
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleRetakePhotoButton() {
        
        self.profileImageview.setImage(UIImage(), for: .normal)
        self.videoPreviewLayer.isHidden = false
        
    }
}

extension CustomPhotoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
    
    @objc func checkForGalleryAuth() {
        
        UIDevice.vibrateLight()
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        
        case .authorized:
            self.openGallery()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    self.openGallery()
                }
            })
            
        case .restricted:
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Camera Permissions in the Settings application.") { (complete) in
                print("Permissions Alert presented")
            }
        case .denied:
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Camera Permissions in the Settings application.") { (complete) in
                print("Permissions Alert presented")
            }
        default :
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Camera Permissions in the Settings application.") { (complete) in
                print("Permissions Alert presented")
            }
        }
    }
    
    func openGallery() {
        
        self.setupAndStartCaptureSession()
        
    }
    
    func setupAndStartCaptureSession(){
        
        DispatchQueue.global(qos: .userInitiated).async {

            self.captureSession = AVCaptureSession()
            self.captureSession.sessionPreset = .medium
            self.captureSession.beginConfiguration()

            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }
            
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            self.setupInputs()
            
        }
    }
    
    func setupInputs() {
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
                print("Unable to access back camera!")
            return
        }
        
        do {
            
            let input = try AVCaptureDeviceInput(device: frontCamera)
            self.stillImageOutput = AVCapturePhotoOutput()

            if self.captureSession.canAddInput(input) && self.captureSession.canAddOutput(stillImageOutput) {
                self.captureSession.addInput(input)
                self.captureSession.addOutput(self.stillImageOutput)
                self.setupLivePreview()
            }
        }
        
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func setupLivePreview() {
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.videoPreviewLayer.videoGravity = .resizeAspectFill
        self.videoPreviewLayer.connection?.videoOrientation = .portrait
        self.videoPreviewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        self.videoPreviewLayer.connection?.isVideoMirrored = false
        
        DispatchQueue.main.async {
            self.profileImageview.layer.addSublayer(self.videoPreviewLayer)
        }
        
        self.captureSession.commitConfiguration()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
        
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.profileImageview.bounds
        }
    }
   
    func takeLiveViewPhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        self.stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()else { return }
        
        let image = UIImage(data: imageData)
        
        if let safeImage = image {
            
            self.profileImageview.setImage(safeImage, for: .normal)
            self.videoPreviewLayer.isHidden = true
            self.retakePhotoButton.isHidden = false

        }
    }
}
