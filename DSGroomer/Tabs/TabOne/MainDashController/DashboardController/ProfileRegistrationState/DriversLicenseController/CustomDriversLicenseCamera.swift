//
//  CustomDriversLicenseCamera.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//


import Foundation
import UIKit
import AVFoundation
import MobileCoreServices
import Photos

class CustomDriversLicenseCamera : UIViewController {
    
    var driverLicenseController : DriverLicenseController?
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    var captureSession : AVCaptureSession!,
        frontCamera : AVCaptureDevice!,
        stillImageOutput: AVCapturePhotoOutput!,
        videoPreviewLayer: AVCaptureVideoPreviewLayer!,
        isInLockedMode : Bool = true
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .times), for: .normal)
        cbf.titleLabel?.tintColor = coreWhiteColor
        cbf.setTitleColor(coreWhiteColor, for: .normal)
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var profileImageview : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = imagePermissionsGrey
        cbf.contentMode = .scaleAspectFill
        cbf.layer.borderColor = coreOrangeColor.cgColor
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 70, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .camera), for: .normal)
        cbf.clipsToBounds = true
        cbf.imageView?.contentMode = .scaleAspectFill
        cbf.contentMode = .scaleAspectFill
        cbf.addTarget(self, action: #selector(self.handlePermissions), for: .touchUpInside)
        
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
        thl.isHidden = true
        return thl
        
    }()
    
    lazy var errorLookingGoodLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Enable camera access to take\nyour profile picture and continue\nonboarding. You’ll have to take\npictures of the doggies too!"
        thl.font = UIFont(name: dsHeaderFont, size: 14)
        thl.numberOfLines = -1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreOrangeColor
        thl.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        thl.layer.masksToBounds = true
        thl.isHidden = true
        thl.isUserInteractionEnabled = true
        thl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handlePermissions)))
        
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
    
    var triggerContainer : UIView = {
        
        let tc = UIView()
        tc.translatesAutoresizingMaskIntoConstraints = false
        tc.backgroundColor = coreWhiteColor
        
       return tc
    }()
    
    var photoContainer : UIView = {
        
        let tc = UIView()
        tc.translatesAutoresizingMaskIntoConstraints = false
        tc.backgroundColor = .clear
        tc.layer.masksToBounds = true
        tc.layer.borderColor = coreWhiteColor.cgColor
        tc.layer.borderWidth = 13
        
       return tc
    }()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return [.landscapeLeft, .landscapeRight]
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBlackColor
        self.perform(#selector(self.addViews), with: nil, afterDelay: 1.0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        appDel.myOrientation = .landscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if self.captureSession.isRunning {
            self.captureSession.stopRunning()
        }
    }
    
    @objc func addViews() {
        
        self.view.addSubview(self.profileImageview)
        self.view.addSubview(self.lookingGoodLabel)
        self.view.addSubview(self.errorLookingGoodLabel)
        self.view.addSubview(self.triggerContainer)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.photoContainer)
        self.view.addSubview(self.retakePhotoButton)

        self.triggerContainer.addSubview(self.takePhotoButton)

        self.lookingGoodLabel.topAnchor.constraint(equalTo: self.profileImageview.bottomAnchor, constant: 43).isActive = true
        self.lookingGoodLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.lookingGoodLabel.heightAnchor.constraint(equalToConstant: 59).isActive = true
        self.lookingGoodLabel.widthAnchor.constraint(equalToConstant: 257).isActive = true
        self.lookingGoodLabel.layer.cornerRadius = 59/2
        
        self.errorLookingGoodLabel.topAnchor.constraint(equalTo: self.profileImageview.bottomAnchor, constant: 43).isActive = true
        self.errorLookingGoodLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.errorLookingGoodLabel.heightAnchor.constraint(equalToConstant: 113).isActive = true
        self.errorLookingGoodLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.errorLookingGoodLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.errorLookingGoodLabel.layer.cornerRadius = 113/2
       
        self.retakePhotoButton.centerXAnchor.constraint(equalTo: self.photoContainer.rightAnchor, constant: 0).isActive = true
        self.retakePhotoButton.centerYAnchor.constraint(equalTo: self.photoContainer.centerYAnchor, constant: 0).isActive = true
        self.retakePhotoButton.heightAnchor.constraint(equalToConstant: 49).isActive = true
        self.retakePhotoButton.widthAnchor.constraint(equalToConstant: 49).isActive = true
        self.retakePhotoButton.layer.cornerRadius = 49/2
        
        self.triggerContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.triggerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.triggerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.triggerContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3.5).isActive = true
        
        self.takePhotoButton.centerYAnchor.constraint(equalTo: self.triggerContainer.centerYAnchor, constant: 0).isActive = true
        self.takePhotoButton.centerXAnchor.constraint(equalTo: self.triggerContainer.centerXAnchor, constant: 0).isActive = true
        self.takePhotoButton.heightAnchor.constraint(equalToConstant: 78).isActive = true
        self.takePhotoButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        self.takePhotoButton.layer.cornerRadius = 78/2
        
        self.profileImageview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.profileImageview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.profileImageview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.profileImageview.rightAnchor.constraint(equalTo: self.triggerContainer.leftAnchor, constant: 0).isActive = true
        self.profileImageview.backgroundColor = .blue
        
        let safeCardFrameArea = ((UIScreen.main.bounds.width) - (UIScreen.main.bounds.width / 3.5))
        let width = safeCardFrameArea / 1.5
        let ratioDifference = width * 1.586
        let height = width - ratioDifference
        
        self.photoContainer.centerYAnchor.constraint(equalTo: self.profileImageview.centerYAnchor, constant: 0).isActive = true
        self.photoContainer.centerXAnchor.constraint(equalTo: self.profileImageview.centerXAnchor, constant: 0).isActive = true
        self.photoContainer.heightAnchor.constraint(equalToConstant: abs(height)).isActive = true
        self.photoContainer.widthAnchor.constraint(equalToConstant: abs(width)).isActive = true
        
        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 38).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 43).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.view.backgroundColor = coreBackgroundWhite
        
        self.checkForGalleryAuth()

    }
    
    @objc func handlePermissions() {
        if self.isInLockedMode == true {
            
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permission", message: "Please head over to the Settings application and enable Camera permissions.") { complete in
                print("Alert for permissions")
            }
        }
    }
    
    @objc func handleTakePhotoButton() {
        
        if self.takePhotoButton.titleLabel?.text == nil {
            self.takeLiveViewPhoto()
        } else {
            self.handleBackButton()
        }
    }
    
    @objc func handleBackButton() {
        
        self.appDel.myOrientation = .portrait
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleRetakePhotoButton() {
        
        self.takePhotoButton.setTitle("", for: .normal)
        self.profileImageview.setImage(UIImage(), for: .normal)
        self.videoPreviewLayer.isHidden = false
        self.takePhotoButton.titleLabel?.text = nil
        self.driverLicenseController?.undoPhoto()
        self.driverLicenseController?.selectedImage = nil
        self.driverLicenseController?.driversLicensePath = nil

    }
    
    func setPhoto(passedPhoto : UIImage) {
        
        self.driverLicenseController?.driversLicenseImageButton.setTitle("", for: .normal)
        self.driverLicenseController?.driversLicenseImageButton.setImage(passedPhoto, for: .normal)
        self.driverLicenseController?.selectedImage = passedPhoto
        self.driverLicenseController?.driversLicensePath = nil
        self.driverLicenseController?.submitButton.alpha = 1.0
        self.driverLicenseController?.submitButton.isEnabled = true
        
    }
}

extension CustomDriversLicenseCamera: UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
    
    @objc func checkForGalleryAuth() {
        
        UIDevice.vibrateLight()
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        
        case .authorized:
            self.cameraLock(isLocked: false)
            self.openGallery()
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    self.openGallery()
                    self.cameraLock(isLocked: false)
                }
            })
            
        case .restricted: self.cameraLock(isLocked: true)
            
        case .denied: self.cameraLock(isLocked: true)
            
        default : self.cameraLock(isLocked: true)
            
        }
    }
    
    func openGallery() {
        
        self.setupAndStartCaptureSession()
        
    }
    
    func setupAndStartCaptureSession() {
        
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
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            self.cameraLock(isLocked: true)
            self.handleBackButton()
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
            self.cameraLock(isLocked: true)
        }
    }
    
    func setupLivePreview() {
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.videoPreviewLayer.videoGravity = .resizeAspectFill
        self.videoPreviewLayer.connection?.videoOrientation = .landscapeLeft
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
    
    
    func cameraLock(isLocked : Bool) {
        
        DispatchQueue.main.async {
            
            if isLocked {
                
                //PERMISSIONS ARE DISABLED
                self.profileImageview.titleLabel?.font = UIFont.fontAwesome(ofSize: 70, style: .solid)
                self.profileImageview.setTitle(String.fontAwesomeIcon(name: .lock), for: .normal)
                self.lookingGoodLabel.isHidden = true
                self.errorLookingGoodLabel.isHidden = false
                self.isInLockedMode = true
                self.handleCustomPermissions()
                
            } else {
                
                //PERMISSIONS ARE ENABLED
                self.profileImageview.setTitle("", for: .normal)
                self.lookingGoodLabel.isHidden = false
                self.errorLookingGoodLabel.isHidden = true
                self.isInLockedMode = false
                
            }
        }
    }
   
    func takeLiveViewPhoto() {
        
        UIDevice.vibrateLight()
        
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
            self.cameraLock(isLocked: false)
            
            self.takePhotoButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 60, style: .solid)
            self.takePhotoButton.setTitle(String.fontAwesomeIcon(name: .checkCircle), for: .normal)
            self.takePhotoButton.setTitleColor(coreOrangeColor, for: .normal)
            
            self.setPhoto(passedPhoto: safeImage)
            
        }
    }
    
    @objc func handleCustomPermissions() {
        
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {return}
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    debugPrint("User has moved to the Applications Settings Menu")
                })
            }
        } else {
            print("hittin here")
        }
    }
}