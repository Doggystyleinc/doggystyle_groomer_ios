//
//  TimeLineCollectionView.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/17/21.
//

//
//  GroomzCollectionView.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/17/21.
//

import Foundation
import UIKit

class TimeLineCollectionView : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    private let timelineID = "timelineID"
    
    var timeLineDetails : TimeLineDetails?
    
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
        
        self.register(TimeLineFeeder.self, forCellWithReuseIdentifier: self.timelineID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 160)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.timelineID, for: indexPath) as! TimeLineFeeder
        
        cell.timeLineCollectionView = self
        
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

class TimeLineFeeder : UICollectionViewCell {
    
    var timeLineCollectionView : TimeLineCollectionView?
    
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
        thl.text = "Tue, Dec 7, 2021"
        thl.font = UIFont(name: rubikMedium, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    let clockInLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Clock in:"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let clockOutLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Clock out:"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let totalHoursLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Total hours:"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let clockInTimeValue : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "6:59am"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    let clockOutTimeValue : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "3:00pm"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    let totalHoursValue : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "8:01"
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
        
        self.addSubview(self.containerView)
        
        self.containerView.addSubview(self.headerDateLabel)
        
        self.containerView.addSubview(self.clockInLabel)
        self.containerView.addSubview(self.clockOutLabel)
        self.containerView.addSubview(self.totalHoursLabel)
        
        self.containerView.addSubview(self.clockInTimeValue)
        self.containerView.addSubview(self.clockOutTimeValue)
        self.containerView.addSubview(self.totalHoursValue)

        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        self.headerDateLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20).isActive = true
        self.headerDateLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 27).isActive = true
        self.headerDateLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -20).isActive = true
        self.headerDateLabel.sizeToFit()
        
        let width = (UIScreen.main.bounds.width - 60 - 27 - 20)
        
        self.clockInLabel.leftAnchor.constraint(equalTo: self.headerDateLabel.leftAnchor, constant: 0).isActive = true
        self.clockInLabel.topAnchor.constraint(equalTo: self.headerDateLabel.bottomAnchor, constant: 16).isActive = true
        self.clockInLabel.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.clockInLabel.sizeToFit()
        
        self.clockOutLabel.leftAnchor.constraint(equalTo: self.headerDateLabel.leftAnchor, constant: 0).isActive = true
        self.clockOutLabel.topAnchor.constraint(equalTo: self.clockInLabel.bottomAnchor, constant: 10).isActive = true
        self.clockOutLabel.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.clockOutLabel.sizeToFit()
        
        self.totalHoursLabel.leftAnchor.constraint(equalTo: self.headerDateLabel.leftAnchor, constant: 0).isActive = true
        self.totalHoursLabel.topAnchor.constraint(equalTo: self.clockOutLabel.bottomAnchor, constant: 10).isActive = true
        self.totalHoursLabel.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.totalHoursLabel.sizeToFit()
        
        self.clockInTimeValue.rightAnchor.constraint(equalTo: self.headerDateLabel.rightAnchor, constant: 0).isActive = true
        self.clockInTimeValue.centerYAnchor.constraint(equalTo: self.clockInLabel.centerYAnchor, constant: 0).isActive = true
        self.clockInTimeValue.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.clockInTimeValue.sizeToFit()
        
        self.clockOutTimeValue.rightAnchor.constraint(equalTo: self.headerDateLabel.rightAnchor, constant: 0).isActive = true
        self.clockOutTimeValue.centerYAnchor.constraint(equalTo: self.clockOutLabel.centerYAnchor, constant: 0).isActive = true
        self.clockOutTimeValue.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.clockOutTimeValue.sizeToFit()
        
        self.totalHoursValue.rightAnchor.constraint(equalTo: self.headerDateLabel.rightAnchor, constant: 0).isActive = true
        self.totalHoursValue.centerYAnchor.constraint(equalTo: self.totalHoursLabel.centerYAnchor, constant: 0).isActive = true
        self.totalHoursValue.widthAnchor.constraint(equalToConstant: width / 2.1).isActive = true
        self.totalHoursValue.sizeToFit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


