//
//  DashboardCollectionSubview.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/13/21.
//


import Foundation
import UIKit


class DashboardCollectionSubview : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let mainDashID = "dashHeaderID"
    
    var dashboardController : DashboardController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(DashboardMainFeeder.self, forCellWithReuseIdentifier: self.mainDashID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 1.15, height: 153)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.mainDashID, for: indexPath) as! DashboardMainFeeder
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
