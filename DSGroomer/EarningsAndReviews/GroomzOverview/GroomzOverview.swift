//
//  GroomzOverview.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/17/21.
//

import Foundation
import UIKit

class GroomzOverview : UIViewController, UIScrollViewDelegate {
    
    var groomzDetailsController : GroomzDetailsController?,
        isWarningPresented : Bool = false,
        contentHeight : CGFloat = 810

    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        return cbf
         
    }()
    
    let headerLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Groom Details"
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let aptHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Appt 4567: Rex & Jolene"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var headerContainerView : UIButton = {
        
        let cv = UIButton()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreWhiteColor
        cv.layer.masksToBounds = true
        cv.layer.cornerRadius = 15
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        cv.layer.shadowOpacity = 0.05
        cv.layer.shadowOffset = CGSize(width: 2, height: 3)
        cv.layer.shadowRadius = 9
        cv.layer.shouldRasterize = false
        cv.isUserInteractionEnabled = true
        
        return cv
    }()
    
    let dateLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Date:"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let servicesLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Services:"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let dateValue : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "Dec 1, 11:00-12:44pm"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    let servicesValue : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "Full Package+"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    let ratingLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Rating"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var stackView : UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.spacing = 0
        
        return sv
    }()
    
    lazy var starOne : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 35, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        return cbf
        
    }()
    
    lazy var starTwo : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 35, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        return cbf
        
    }()
    
    lazy var starThree : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 35, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        return cbf
        
    }()
    
    lazy var starFour : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 35, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        return cbf
        
    }()
    
    lazy var starFive : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 35, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        return cbf
        
    }()
    
    let ownerCommentsLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Owner Comments"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var ownerCommentsContainerView : UIButton = {
        
        let cv = UIButton()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreWhiteColor
        cv.layer.masksToBounds = true
        cv.layer.cornerRadius = 15
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        cv.layer.shadowOpacity = 0.05
        cv.layer.shadowOffset = CGSize(width: 2, height: 3)
        cv.layer.shadowRadius = 9
        cv.layer.shouldRasterize = false
        cv.isUserInteractionEnabled = true
        
        return cv
    }()
    
    let ownersCommentsTextView : UITextView = {
        
        let tv = UITextView()
        tv.backgroundColor = coreWhiteColor
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = coreBlackColor
        tv.textAlignment = .left
        tv.isUserInteractionEnabled = true
        tv.isScrollEnabled = true
        tv.alwaysBounceVertical = true
        tv.alwaysBounceHorizontal = false
        tv.text = "Rex is finally clean as a whistle! Thanks for taking such good care of him, I’m sure he’s looking forward to next month’s appointment."
        tv.font = UIFont(name: rubikRegular, size: 13)
        tv.isUserInteractionEnabled = true
        tv.isScrollEnabled = true
        tv.isEditable = false
        tv.isSelectable = true
        
        return tv
    }()
    
    lazy var infoContainerView : UIButton = {
        
        let cv = UIButton()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreWhiteColor
        cv.layer.masksToBounds = true
        cv.layer.cornerRadius = 15
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        cv.layer.shadowOpacity = 0.05
        cv.layer.shadowOffset = CGSize(width: 2, height: 3)
        cv.layer.shadowRadius = 9
        cv.layer.shouldRasterize = false
        cv.isUserInteractionEnabled = true
        
        return cv
    }()
    
    let ownerNameLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Owner Name:"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let totalTipLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Total Tip:"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let ownersValue : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "Bruce"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    let tipsValue : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "$32.00"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    lazy var tipButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Send thanks for tip", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleSendThanksForTip), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var tipPopUp : TipPopUp = {
        
        let rp = TipPopUp()
        rp.translatesAutoresizingMaskIntoConstraints = true
        rp.groomzOverview = self

        return rp
    }()
    
    let backDrop : UIView = {
        let bd = UIView()
        bd.translatesAutoresizingMaskIntoConstraints = false
        bd.backgroundColor = UIColor (white: 0, alpha: 0.5)
        bd.alpha = 0
       return bd
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
        sv.delaysContentTouches = false
        
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
    }
    
    func addViews() {
        
        let width = (UIScreen.main.bounds.width - 60 - 27 - 20)
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.backButton)
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.aptHeaderLabel)
        self.contentView.addSubview(self.headerContainerView)
        
        self.headerContainerView.addSubview(self.dateLabel)
        self.headerContainerView.addSubview(self.servicesLabel)
        self.headerContainerView.addSubview(self.dateValue)
        self.headerContainerView.addSubview(self.servicesValue)
        
        self.contentView.addSubview(self.ratingLabel)
        
        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.starOne)
        self.stackView.addArrangedSubview(self.starTwo)
        self.stackView.addArrangedSubview(self.starThree)
        self.stackView.addArrangedSubview(self.starFour)
        self.stackView.addArrangedSubview(self.starFive)
        
        self.contentView.addSubview(self.ownerCommentsLabel)
        self.contentView.addSubview(self.ownerCommentsContainerView)
        self.ownerCommentsContainerView.addSubview(self.ownersCommentsTextView)
        
        self.contentView.addSubview(self.infoContainerView)
        
        self.infoContainerView.addSubview(self.ownerNameLabel)
        self.infoContainerView.addSubview(self.totalTipLabel)
        self.infoContainerView.addSubview(self.ownersValue)
        self.infoContainerView.addSubview(self.tipsValue)
        
        self.contentView.addSubview(self.tipButton)
        self.contentView.addSubview(self.backDrop)
        self.view.addSubview(self.tipPopUp)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentHeight)
        
        self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 0).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: 0).isActive = true
        self.contentView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: 800).isActive = true

        self.backButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 17).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.headerLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.aptHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.aptHeaderLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 20).isActive = true
        self.aptHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.aptHeaderLabel.sizeToFit()
        
        self.headerContainerView.topAnchor.constraint(equalTo: self.aptHeaderLabel.bottomAnchor, constant: 20).isActive = true
        self.headerContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerContainerView.heightAnchor.constraint(equalToConstant: 114).isActive = true
        
        self.dateLabel.leftAnchor.constraint(equalTo: self.headerContainerView.leftAnchor, constant: 25).isActive = true
        self.dateLabel.topAnchor.constraint(equalTo: self.headerContainerView.topAnchor, constant: 25).isActive = true
        self.dateLabel.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.dateLabel.sizeToFit()
        
        self.dateValue.rightAnchor.constraint(equalTo: self.headerContainerView.rightAnchor, constant: -20).isActive = true
        self.dateValue.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor, constant: 0).isActive = true
        self.dateValue.widthAnchor.constraint(equalToConstant: width / 1.8).isActive = true
        self.dateValue.sizeToFit()
        
        self.servicesLabel.leftAnchor.constraint(equalTo: self.headerContainerView.leftAnchor, constant: 25).isActive = true
        self.servicesLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 16).isActive = true
        self.servicesLabel.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.servicesLabel.sizeToFit()
        
        self.servicesValue.rightAnchor.constraint(equalTo: self.headerContainerView.rightAnchor, constant: -20).isActive = true
        self.servicesValue.centerYAnchor.constraint(equalTo: self.servicesLabel.centerYAnchor, constant: 0).isActive = true
        self.servicesValue.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.servicesValue.sizeToFit()
        
        self.ratingLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.ratingLabel.topAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor, constant: 32).isActive = true
        self.ratingLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.ratingLabel.sizeToFit()
      
        self.starOne.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.starTwo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.starThree.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.starFour.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.starFive.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.stackView.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 16).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.ratingLabel.leftAnchor, constant: 0).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.stackView.sizeToFit()
        
        self.ownerCommentsLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.ownerCommentsLabel.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 32).isActive = true
        self.ownerCommentsLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.ownerCommentsLabel.sizeToFit()
        
        self.ownerCommentsContainerView.topAnchor.constraint(equalTo: self.ownerCommentsLabel.bottomAnchor, constant: 18).isActive = true
        self.ownerCommentsContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.ownerCommentsContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.ownerCommentsContainerView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        self.ownersCommentsTextView.topAnchor.constraint(equalTo: self.ownerCommentsContainerView.topAnchor, constant: 10).isActive = true
        self.ownersCommentsTextView.leftAnchor.constraint(equalTo: self.ownerCommentsContainerView.leftAnchor, constant: 10).isActive = true
        self.ownersCommentsTextView.rightAnchor.constraint(equalTo: self.ownerCommentsContainerView.rightAnchor, constant: -10).isActive = true
        self.ownersCommentsTextView.bottomAnchor.constraint(equalTo: self.ownerCommentsContainerView.bottomAnchor, constant: -10).isActive = true
        
        self.infoContainerView.topAnchor.constraint(equalTo: self.ownerCommentsContainerView.bottomAnchor, constant: 20).isActive = true
        self.infoContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.infoContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.infoContainerView.heightAnchor.constraint(equalToConstant: 114).isActive = true
        
        self.ownerNameLabel.leftAnchor.constraint(equalTo: self.infoContainerView.leftAnchor, constant: 24).isActive = true
        self.ownerNameLabel.topAnchor.constraint(equalTo: self.infoContainerView.topAnchor, constant: 25).isActive = true
        self.ownerNameLabel.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.ownerNameLabel.sizeToFit()
        
        self.ownersValue.rightAnchor.constraint(equalTo: self.infoContainerView.rightAnchor, constant: -20).isActive = true
        self.ownersValue.centerYAnchor.constraint(equalTo: self.ownerNameLabel.centerYAnchor, constant: 0).isActive = true
        self.ownersValue.widthAnchor.constraint(equalToConstant: width / 1.8).isActive = true
        self.ownersValue.sizeToFit()
        
        self.totalTipLabel.leftAnchor.constraint(equalTo: self.infoContainerView.leftAnchor, constant: 22).isActive = true
        self.totalTipLabel.topAnchor.constraint(equalTo: self.ownerNameLabel.bottomAnchor, constant: 16).isActive = true
        self.totalTipLabel.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.totalTipLabel.sizeToFit()
        
        self.tipsValue.rightAnchor.constraint(equalTo: self.infoContainerView.rightAnchor, constant: -20).isActive = true
        self.tipsValue.centerYAnchor.constraint(equalTo: self.totalTipLabel.centerYAnchor, constant: 0).isActive = true
        self.tipsValue.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.tipsValue.sizeToFit()
        
        self.tipButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.tipButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.tipButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.tipButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.backDrop.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backDrop.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.backDrop.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.backDrop.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

    }
    
    @objc func handleWarningIcon() {

        if self.isWarningPresented {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.tipPopUp.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 463)
                self.backDrop.alpha = 0
                self.view.layoutIfNeeded()
                self.tipPopUp.layoutIfNeeded()
            } completion: { complete in
                self.isWarningPresented = false
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.tipPopUp.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - 463), width: UIScreen.main.bounds.width, height: 463)
                self.view.layoutIfNeeded()
                self.tipPopUp.layoutIfNeeded()
                self.backDrop.alpha = 1

            } completion: { complete in
                self.isWarningPresented = true
            }
        }
    }
    
    @objc func handleSendThanksForTip() {
        self.handleWarningIcon()
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
