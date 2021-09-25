//
//  CompleteProfileController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/23/21.
//

import Foundation
import Firebase
import UIKit
import AVFoundation
import MobileCoreServices
import Photos

class CompleteProfileController : UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var dashboardController : DashboardController?,
        selectedImage : UIImage?,
        contentOffSet : CGFloat = 0.0,
        contentHeight : CGFloat = 685,
        lastKeyboardHeight : CGFloat = 0.0,
        isKeyboardShowing : Bool = false,
        databaseRef = Database.database().reference()

    let mainLoadingScreen = MainLoadingScreen()
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let headerLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "Complete profile"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        
        return hl
    }()
    
    lazy var profileContainer : UIButton = {
        
        let fpc = UIButton(type: .system)
        fpc.translatesAutoresizingMaskIntoConstraints = false
        fpc.backgroundColor = coreWhiteColor
        fpc.isUserInteractionEnabled = true
        fpc.layer.masksToBounds = false
        fpc.layer.cornerRadius = 20
        fpc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        fpc.layer.shadowOpacity = 0.05
        fpc.layer.shadowOffset = CGSize(width: 2, height: 3)
        fpc.layer.shadowRadius = 9
        fpc.layer.shouldRasterize = false
        
        return fpc
    }()
    
    let profileImageView : UIImageView = {
        
        let piv = UIImageView()
        piv.translatesAutoresizingMaskIntoConstraints = false
        piv.backgroundColor = coreBackgroundWhite
        piv.contentMode = .scaleAspectFill
        piv.isUserInteractionEnabled = false
        piv.clipsToBounds = true
        
        return piv
    }()
    
    let headerProfileLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = ""
        thl.font = UIFont(name: dsSubHeaderFont, size: 20)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let headerProfileSubLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Let your team and clients know a little about you"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 3
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreOrangeColor
        return thl
        
    }()
    
    lazy var pencilIconButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.masksToBounds = true
        cbf.layer.borderColor = coreOrangeColor.cgColor
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .pencilAlt), for: .normal)
        cbf.setTitleColor(coreWhiteColor, for: .normal)
        cbf.tintColor = coreWhiteColor
        cbf.layer.borderWidth = 2
        cbf.layer.borderColor = coreWhiteColor.cgColor
        cbf.addTarget(self, action: #selector(self.checkForGalleryAuth), for: .touchUpInside)
        
        return cbf
        
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        
        let ai = UIActivityIndicatorView(style: .medium)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.backgroundColor = .clear
        ai.hidesWhenStopped = true
        
       return ai
        
    }()
    
    lazy var dogBreedTextField: CustomTextField = {
        
        let etfc = CustomTextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.light
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .alphabet
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 8
        etfc.leftViewMode = .always
        etfc.layer.borderColor = UIColor.clear.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        etfc.clipsToBounds = false
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.isUserInteractionEnabled = true
        etfc.addTarget(self, action: #selector(self.handleBreedFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handleBreedTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    let typingBreedLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "Dog breed"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        
        return tel
    }()
    
    let placeHolderBreedLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Favorite dog breed"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    lazy var homeTownTextField: CustomTextField = {
        
        let etfc = CustomTextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.light
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .alphabet
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 8
        etfc.leftViewMode = .always
        etfc.layer.borderColor = UIColor.clear.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        etfc.clipsToBounds = false
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.isUserInteractionEnabled = true
        etfc.addTarget(self, action: #selector(self.handleHometownFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handleHometownTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    let typingHomeTownLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "Hometown"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        
        return tel
    }()
    
    let placeHolderHomeTownLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Hometown"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    lazy var notesTextView: UITextView = {
        
        let etfc = UITextView()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        
        etfc.keyboardAppearance = UIKeyboardAppearance.light
        etfc.returnKeyType = .default
        
        etfc.layer.cornerRadius = 10
        etfc.layer.borderColor = UIColor.clear.cgColor
        etfc.layer.borderWidth = 1
        etfc.layer.masksToBounds = false
        
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        
        etfc.isUserInteractionEnabled = true
        etfc.clipsToBounds = true
        etfc.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleNotesTouch)))
        
        return etfc
        
    }()
    
    let textviewPlaceholder : UILabel = {
        
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.backgroundColor = .clear
        nl.text = "Tell us a little about yourself"
        nl.font = UIFont(name: rubikRegular, size: 18)
        nl.textColor = dsFlatBlack.withAlphaComponent(0.4)
        nl.textAlignment = .left
        nl.adjustsFontSizeToFitWidth = true
        nl.numberOfLines = -1
        nl.isUserInteractionEnabled = false
        
       return nl
    }()
    
    lazy var saveButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Save", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont(name: rubikMedium, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleSaveButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var scrollView : UIScrollView = {
        
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = coreBackgroundWhite
        sv.isScrollEnabled = true
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 1.0
        sv.bounces = true
        sv.bouncesZoom = true
        sv.isHidden = false
        sv.delegate = self
        sv.contentMode = .scaleAspectFit
        sv.isUserInteractionEnabled = true
        sv.delaysContentTouches = true
        
        return sv
        
    }()
    
    let contentView : UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.isUserInteractionEnabled = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        
        self.addViews()
        self.fillValues()
        
        self.scrollView.keyboardDismissMode = .interactive
        self.notesTextView.contentInset = UIEdgeInsets(top: 18, left: 10, bottom: 18, right: 10)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.scrollView)

        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.backButton)
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.profileContainer)
        
        self.profileContainer.addSubview(self.profileImageView)
        self.profileContainer.addSubview(self.headerProfileLabel)
        self.profileContainer.addSubview(self.headerProfileSubLabel)
        self.profileContainer.addSubview(self.pencilIconButton)
        
        self.contentView.addSubview(self.activityIndicator)
        
        //MARK: - DOG BREED TEXTFIELD
        self.contentView.addSubview(self.dogBreedTextField)
        self.contentView.addSubview(self.placeHolderBreedLabel)
        self.contentView.addSubview(self.typingBreedLabel)
        
        //MARK: - HOMETOWN TEXTFIELD
        self.contentView.addSubview(self.homeTownTextField)
        self.contentView.addSubview(self.placeHolderHomeTownLabel)
        self.contentView.addSubview(self.typingHomeTownLabel)
        
        self.contentView.addSubview(self.notesTextView)
        self.contentView.addSubview(self.textviewPlaceholder)
        self.contentView.addSubview(self.saveButton)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentHeight + self.lastKeyboardHeight)
        
        self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 0).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: 0).isActive = true
        self.contentView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: 675).isActive = true

        self.backButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 17).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 32).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.profileContainer.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15).isActive = true
        self.profileContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.profileContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.profileContainer.heightAnchor.constraint(equalToConstant: 137).isActive = true
        
        self.profileImageView.centerYAnchor .constraint(equalTo: self.profileContainer.centerYAnchor, constant: 0).isActive = true
        self.profileImageView.leftAnchor.constraint(equalTo: self.profileContainer.leftAnchor, constant: 24).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 99).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 99).isActive = true
        self.profileImageView.layer.cornerRadius = 99/2
        
        self.headerProfileLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: -15).isActive = true
        self.headerProfileLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 25).isActive = true
        self.headerProfileLabel.rightAnchor.constraint(equalTo: self.profileContainer.rightAnchor, constant: -25).isActive = true
        self.headerProfileLabel.sizeToFit()
        
        self.headerProfileSubLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: 15).isActive = true
        self.headerProfileSubLabel.leftAnchor.constraint(equalTo: self.headerProfileLabel.leftAnchor, constant: 0).isActive = true
        self.headerProfileSubLabel.rightAnchor.constraint(equalTo: self.profileContainer.rightAnchor, constant: -25).isActive = true
        self.headerProfileSubLabel.sizeToFit()
        
        self.pencilIconButton.centerXAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: -13).isActive = true
        self.pencilIconButton.centerYAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: -13).isActive = true
        self.pencilIconButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        self.pencilIconButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        self.pencilIconButton.layer.cornerRadius = 28/2
        
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: 0).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.profileImageView.centerXAnchor, constant: 0).isActive = true
        self.activityIndicator.sizeToFit()
        
        //MARK: - DOG BREED TEXTFIELD
        self.dogBreedTextField.topAnchor.constraint(equalTo: self.profileContainer.bottomAnchor, constant: 20).isActive = true
        self.dogBreedTextField.leftAnchor.constraint(equalTo: self.profileContainer.leftAnchor, constant: 0).isActive = true
        self.dogBreedTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.dogBreedTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderBreedLabel.leftAnchor.constraint(equalTo: self.dogBreedTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderBreedLabel.centerYAnchor.constraint(equalTo: self.dogBreedTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderBreedLabel.sizeToFit()
        
        self.typingBreedLabel.leftAnchor.constraint(equalTo: self.dogBreedTextField.leftAnchor, constant: 25).isActive = true
        self.typingBreedLabel.topAnchor.constraint(equalTo: self.dogBreedTextField.topAnchor, constant: 14).isActive = true
        self.typingBreedLabel.sizeToFit()
        
        //MARK: - HOMETOWN TEXTFIELD
        self.homeTownTextField.topAnchor.constraint(equalTo: self.dogBreedTextField.bottomAnchor, constant: 20).isActive = true
        self.homeTownTextField.leftAnchor.constraint(equalTo: self.profileContainer.leftAnchor, constant: 0).isActive = true
        self.homeTownTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.homeTownTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderHomeTownLabel.leftAnchor.constraint(equalTo: self.homeTownTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderHomeTownLabel.centerYAnchor.constraint(equalTo: self.homeTownTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderHomeTownLabel.sizeToFit()
        
        self.typingHomeTownLabel.leftAnchor.constraint(equalTo: self.homeTownTextField.leftAnchor, constant: 25).isActive = true
        self.typingHomeTownLabel.topAnchor.constraint(equalTo: self.homeTownTextField.topAnchor, constant: 14).isActive = true
        self.typingHomeTownLabel.sizeToFit()
        
        //MARK: - NOTES TEXTVIEW
        self.notesTextView.topAnchor.constraint(equalTo: self.homeTownTextField.bottomAnchor, constant: 20).isActive = true
        self.notesTextView.leftAnchor.constraint(equalTo: self.homeTownTextField.leftAnchor, constant: 0).isActive = true
        self.notesTextView.rightAnchor.constraint(equalTo: self.homeTownTextField.rightAnchor, constant: 0).isActive = true
        self.notesTextView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        self.textviewPlaceholder.topAnchor.constraint(equalTo: self.notesTextView.topAnchor, constant: 18).isActive = true
        self.textviewPlaceholder.leftAnchor.constraint(equalTo: self.notesTextView.leftAnchor, constant: 30).isActive = true
        self.textviewPlaceholder.rightAnchor.constraint(equalTo: self.notesTextView.rightAnchor, constant: -10).isActive = true
        self.textviewPlaceholder.sizeToFit()
        
        //MARK: - SAVE BUTTON
        self.saveButton.leftAnchor.constraint(equalTo: self.homeTownTextField.leftAnchor, constant: 0).isActive = true
        self.saveButton.rightAnchor.constraint(equalTo: self.homeTownTextField.rightAnchor, constant: 0).isActive = true
        self.saveButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.saveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    @objc func adjustContentSize() {
        
        self.scrollView.layoutIfNeeded()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentHeight + self.lastKeyboardHeight)
        self.scrollView.scrollToBottom()
        
    }
    
    @objc func handleKeyboardShow(notification : Notification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        if keyboardRectangle.height > 200 {
            
            if self.isKeyboardShowing == true {return}
            self.isKeyboardShowing = true
            
            self.lastKeyboardHeight = keyboardRectangle.height
            self.perform(#selector(self.handleKeyboardMove), with: nil, afterDelay: 0.1)
            
        }
    }
    
    @objc func handleKeyboardHide(notification : Notification) {
        
        self.isKeyboardShowing = false
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        self.lastKeyboardHeight = keyboardRectangle.height
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentHeight)
    }
    
    @objc func handleKeyboardMove() {
        self.adjustContentSize()
    }
    
    
    @objc func handleNotesTouch() {
        self.textviewPlaceholder.isHidden = true
        self.notesTextView.becomeFirstResponder()
    }
    
    func fillValues() {
        
        let usersName = groomerUserStruct.groomers_first_name?.capitalizingFirstLetter() ?? "Doggystylist"
        let memberSince = groomerUserStruct.users_sign_up_date?.returnYearFromTimeStamp() ?? "2021"
        let usersProfileImageURL = groomerUserStruct.profile_image_url ?? "nil"
        
        self.headerProfileLabel.text = usersName
        self.headerProfileSubLabel.text = "Doggystyling since \(memberSince)"
        self.profileImageView.loadImageGeneralUse(usersProfileImageURL) { complete in
            print("done")
        }
    }
    
    @objc func handleBreedFieldChange() {
        
        if self.dogBreedTextField.text != "" {
            self.typingBreedLabel.isHidden = false
            self.placeHolderBreedLabel.isHidden = true
        }
    }
    
    @objc func handleBreedTextFieldBegin() {
        self.typingBreedLabel.isHidden = false
        self.placeHolderBreedLabel.isHidden = true
    }
    
    @objc func handleHometownFieldChange() {
        
        if self.homeTownTextField.text != "" {
            self.typingHomeTownLabel.isHidden = false
            self.placeHolderHomeTownLabel.isHidden = true
        }
    }
    
    @objc func handleHometownTextFieldBegin() {
        self.typingHomeTownLabel.isHidden = false
        self.placeHolderHomeTownLabel.isHidden = true
    }
    
    func uploadImage() {
        
        if self.selectedImage != nil {
            
            guard let safeImage = self.selectedImage else {return}
            
            self.activityInvoke(shouldStart: true)
            
            Service.shared.uploadProfileImage(imageToUpload: safeImage, completion: { isComplete, imageURL  in
                
                if isComplete {
                    
                    groomerUserStruct.profile_image_url = imageURL
                    self.activityInvoke(shouldStart: false)
                    self.dashboardController?.finishProfileSubview.profileImageView.image = safeImage
                    
                } else {
                    
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Photo failed to upload. Please try again. If this issue persists, please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS)") { isComplete in
                        self.handleBackButton()
                    }
                    
                    self.activityInvoke(shouldStart: false)
                    
                }
            })
        }
    }
    
    func resignation() {
        
        self.dogBreedTextField.resignFirstResponder()
        self.homeTownTextField.resignFirstResponder()
        self.notesTextView.resignFirstResponder()
        
    }
    
    @objc func handleSaveButton() {
        
        self.resignation()
        self.scrollView.scrollToTop()
        guard let user_uid = Auth.auth().currentUser?.uid else {return}
        
        guard let breedTextField = self.dogBreedTextField.text else {return}
        guard let hometownTextField = self.homeTownTextField.text else {return}
        guard let notesTextView = self.notesTextView.text else {return}
        
        let cleanBreed = breedTextField.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanHometown = hometownTextField.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAboutYourSelf = notesTextView.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanBreed.count > 2 {
            self.dogBreedTextField.layer.borderColor = UIColor .clear.cgColor
            if cleanHometown.count > 2 {
                self.homeTownTextField.layer.borderColor = UIColor .clear.cgColor
                if cleanAboutYourSelf.count > 20 {
                    
                    self.notesTextView.layer.borderColor = UIColor.clear.cgColor
                    self.dogBreedTextField.layer.borderColor = UIColor .clear.cgColor
                    self.homeTownTextField.layer.borderColor = UIColor .clear.cgColor
                    
                    self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
                    
                    let values : [String : Any] = ["groomers_favorite_dog_breed" : cleanBreed, "groomers_hometown" : cleanHometown, "groomers_bio" : cleanAboutYourSelf]
                    
                    let ref = self.databaseRef.child("all_users").child(user_uid)
                    
                    ref.updateChildValues(values) { error, ref in
                        
                        if error != nil {
                            AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "We are not able to save your bio at this time. Please try again.") { isComplete in
                                print("BIO ALERT")
                            }
                            return
                        }
                        
                        let groomerID = groomerUserStruct.groomer_child_key_from_playbook ?? "nil"
                       
                        
                        if groomerID == "nil" {
                            AlertControllerCompletion.handleAlertWithCompletion(title: "ERROR", message: "Please reach out to HQ @ \(Statics.SUPPORT_EMAIL_ADDRESS) to resolve this matter.") { complete in
                                self.mainLoadingScreen.cancelMainLoadingScreen()
                                self.handleBackButton()
                            }
                        } else {
                            
                            let playbookRef = self.databaseRef.child("play_books").child(groomerID)
                            let playbookValues : [String : Any] = ["groomer_has_completed_biography_management" : true]
                            
                            playbookRef.updateChildValues(playbookValues) { error, ref in
                                
                                if error != nil {
                                    AlertControllerCompletion.handleAlertWithCompletion(title: "ERROR", message: "Please reach out to HQ @ \(Statics.SUPPORT_EMAIL_ADDRESS) to resolve this matter.") { complete in
                                        self.mainLoadingScreen.cancelMainLoadingScreen()
                                        self.handleBackButton()
                                    }
                                    return
                                }
                                
                                self.mainLoadingScreen.cancelMainLoadingScreen()
                                self.dashboardController?.runDataEngine()
                                self.handleBackButton()
                                
                            }
                        }
                    }
                    
                } else {
                    self.notesTextView.layer.borderColor = coreRedColor.cgColor
                }
            } else {
                self.homeTownTextField.layer.borderColor = coreRedColor.cgColor
            }
        } else {
            self.dogBreedTextField.layer.borderColor = coreRedColor.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.handleSaveButton()
        return false
        
    }
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension CompleteProfileController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application.") { (complete) in
                print("Alert presented")
            }
        case .denied:
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application.") { (complete) in
                print("Alert presented")
            }
        default :
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application.") { (complete) in
                print("Alert presented")
            }
        }
    }
    
    func openGallery() {
        
        DispatchQueue.main.async {
            
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            if let topViewController = UIApplication.getTopMostViewController() {
                topViewController.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true) {
            self.selectedImage = nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
            
            let mediaType = info[.mediaType] as! CFString
            
            switch mediaType {
            
            case kUTTypeImage :
                
                if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    
                    self.profileImageView.image = editedImage
                    self.selectedImage = editedImage
                    self.uploadImage()
                    
                } else if let originalImage = info[.originalImage] as? UIImage  {
                    
                    self.profileImageView.image = originalImage
                    self.selectedImage = originalImage
                    self.uploadImage()

                } else {
                    print("Failed grabbing the photo")
                }
                
            default : print("SHOULD NOT HIT FOR THE CAMERA PICKER")
                
            }
        }
    }
    
    func activityInvoke(shouldStart : Bool) {
        
        if shouldStart {
            self.view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.35) {
                self.profileImageView.alpha = 0.25
            } completion: { complete in
                self.activityIndicator.startAnimating()
            }
        } else {
            self.view.isUserInteractionEnabled = true
            UIDevice.vibrateLight()
            UIView.animate(withDuration: 0.35) {
                self.profileImageView.alpha = 1.0
            } completion: { complete in
                self.activityIndicator.stopAnimating()
            }
        }
    }
}




