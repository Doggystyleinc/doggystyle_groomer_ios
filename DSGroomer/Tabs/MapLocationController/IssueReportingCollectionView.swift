//
//  IssueReportingCollectionView.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 11/1/21.
//

import Foundation
import UIKit

class IssueReportingCollectionView : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    private let issueID = "issueID"
    
    var issueReportingPopup : IssueReportingPopup?
    
    let issueReportingArray : [String] = ["Stuck in traffic", "Mechanical issues", "Fuel issues", "Emergency Assistance", "Other"]
    
    var selectionArray = [IndexPath]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = coreWhiteColor
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
        
        self.register(IssueReportingFeeder.self, forCellWithReuseIdentifier: self.issueID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.issueReportingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.issueID, for: indexPath) as! IssueReportingFeeder
        
        cell.issueReportingCollectionView = self
        
        let feeder = self.issueReportingArray[indexPath.item]

        cell.descriptionLabel.text = feeder
        
        if !self.selectionArray.contains(indexPath) {
            cell.selectionButton.setTitle("", for: .normal)
            cell.descriptionLabel.textColor = coreBlackColor
        } else {
            cell.selectionButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 23, style: .solid)
            cell.selectionButton.setTitle(String.fontAwesomeIcon(name: .checkCircle), for: .normal)
            cell.selectionButton.setTitleColor(coreOrangeColor, for: .normal)
            cell.descriptionLabel.textColor = coreBlackColor.withAlphaComponent(0.5)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    @objc func handleSelection(sender : UIButton) {
        
        let selectedButtonCell = sender.superview as! UICollectionViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else {return}
        
        if !self.selectionArray.contains(indexPath) {
            self.selectionArray.append(indexPath)
        } else {
            if let indexOf = self.selectionArray.firstIndex(of: indexPath) {
                self.selectionArray.remove(at: indexOf)
            }
        }
        
        DispatchQueue.main.async {
            self.reloadItems(at: [indexPath])
        }
    }
    
    func clearData() {
        
        self.selectionArray.removeAll()
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IssueReportingFeeder : UICollectionViewCell {
    
    var issueReportingCollectionView : IssueReportingCollectionView?
    
    lazy var dummyButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.layer.masksToBounds = true
        cbf.addTarget(self, action: #selector(self.handleSelection(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var selectionButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.layer.masksToBounds = true
        cbf.layer.borderWidth = 3
        cbf.layer.borderColor = lightGreyButtonColor.cgColor
        cbf.isUserInteractionEnabled = false
        
        return cbf
        
    }()
    
    let descriptionLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreBlackColor
        thl.isUserInteractionEnabled = false

        return thl
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addViews()
        
    }
    
    
    func addViews() {
        
        self.addSubview(self.selectionButton)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.dummyButton)

        self.selectionButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.selectionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.selectionButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.selectionButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.selectionButton.layer.cornerRadius = 15
        
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.selectionButton.rightAnchor, constant: 20).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.descriptionLabel.sizeToFit()
        
        self.dummyButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.dummyButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.dummyButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.dummyButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    @objc func handleSelection(sender : UIButton) {
        
        self.issueReportingCollectionView?.handleSelection(sender: sender)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
