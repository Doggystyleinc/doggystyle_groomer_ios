//
//  PaymentCollectionView.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/17/21.
//

import Foundation
import UIKit

class PaymentCollectionView : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    private let paymentID = "paymentID"
    
    var paymentHistoryController : PaymentHistoryController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = coreBackgroundWhite
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        
        self.isPrefetchingEnabled = false
        self.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsMultipleSelection = true
        self.canCancelContentTouches = false
        self.contentInsetAdjustmentBehavior = .never
        self.delaysContentTouches = true
        
        self.register(PaymentFeeder.self, forCellWithReuseIdentifier: self.paymentID)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 104)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.paymentID, for: indexPath) as! PaymentFeeder
        
        cell.paymentCollectionView = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PaymentFeeder : UICollectionViewCell {
    
    var paymentCollectionView : PaymentCollectionView?
    
    lazy var containerView : UIButton = {
        
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
    
    let headerDateLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "December, 21"
        thl.font = UIFont(name: rubikMedium, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    let dateLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Dec 1 - 15"
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
        thl.text = "$1436.03"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    
    func addViews() {
        
        let width = (UIScreen.main.bounds.width - 60 - 27 - 20)
        
        self.addSubview(self.containerView)
        
        self.containerView.addSubview(self.headerDateLabel)
        self.containerView.addSubview(self.dateLabel)
        self.containerView.addSubview(self.dateValue)

        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        self.headerDateLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20).isActive = true
        self.headerDateLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 27).isActive = true
        self.headerDateLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -20).isActive = true
        self.headerDateLabel.sizeToFit()
        
        self.dateLabel.leftAnchor.constraint(equalTo: self.headerDateLabel.leftAnchor, constant: 0).isActive = true
        self.dateLabel.topAnchor.constraint(equalTo: self.headerDateLabel.bottomAnchor, constant: 16).isActive = true
        self.dateLabel.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.dateLabel.sizeToFit()
        
        self.dateValue.rightAnchor.constraint(equalTo: self.headerDateLabel.rightAnchor, constant: 0).isActive = true
        self.dateValue.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor, constant: 0).isActive = true
        self.dateValue.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.dateValue.sizeToFit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

