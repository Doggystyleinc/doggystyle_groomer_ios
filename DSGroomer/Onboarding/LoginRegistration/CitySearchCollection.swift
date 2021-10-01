//
//  CitySearchCollection.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 10/1/21.
//


import Foundation
import UIKit

class CitySearchCollection : UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private let cityID = "cityID"
    
    var citySearchSubView : CitySearchSubView?
    
    var placesArray = [String](),
        arrayOfDicts = [PlacesDictionary]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = coreWhiteColor
        self.delegate = self
        self.dataSource = self
        self.alpha = 1
        self.isHidden = false
        self.layer.masksToBounds = true
        self.keyboardDismissMode = .interactive
        self.separatorStyle = .none
        self.layer.cornerRadius = 10
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.register(CityFeeder.self, forCellReuseIdentifier: self.cityID)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cityID, for: indexPath) as! CityFeeder
        cell.selectionStyle = .none
        
        if self.placesArray.count != 0 {
            let feeder = self.placesArray[indexPath.item]
            cell.breedLabel.text = feeder
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let feeder = self.placesArray[indexPath.item]
        self.citySearchSubView?.centerConstraint?.constant = 0
        
        
        let places = self.arrayOfDicts[indexPath.item]
        
        print(places)

        let locationName = places.locationName
        let placeID = places.placeId

        if locationName.count <= 0 || placeID.count <= 0 {
            print("error grabbing the name or placeid")
        } else {
        
            self.citySearchSubView?.registrationController?.cityNameFetch = locationName
            self.citySearchSubView?.registrationController?.cityPlacesIdFetch = placeID
            self.citySearchSubView?.registrationController?.fillBreed(breedType: feeder)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CityFeeder : UITableViewCell {
    
    let breedLabel : UILabel = {
        
        let pl = UILabel()
        pl.translatesAutoresizingMaskIntoConstraints = false
        pl.textColor = coreBlackColor
        pl.text = ""
        pl.textAlignment = .left
        pl.font = UIFont(name: rubikRegular, size: 18)
        pl.numberOfLines = 1
        pl.adjustsFontSizeToFitWidth = true
        
        return pl
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor .clear
        self.addViews()
    }
    
    func addViews() {
        
        self.addSubview(self.breedLabel)
        
        self.breedLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        self.breedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        self.breedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        self.breedLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


