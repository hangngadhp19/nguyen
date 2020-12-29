//
//  CompteCourantCell.swift
//  projet
//
//  Created by Hang Nga on 19/12/2020.
//

import Foundation
import UIKit

class CompteCourantCell : UITableViewCell {
 
     var compteCourantData : CompteCourantModel? {
         didSet {
            
            // labelDateCreated.text = compteCourantData?.titleDateCreated
            labelMark.text = compteCourantData?.titleMark == 1 ? "Vire" : compteCourantData?.titleMark == 2 ? "Déposer" : "Retirer"
            labelTypeCompte.text = compteCourantData?.titleTypeCompte == 1 ? "Compte Courant (\(compteCourantData?.titleId)" : compteCourantData?.titleTypeCompte == 2 ? "Compte Livret A" : "Compte Épargne"
            labelArgent.text = compteCourantData?.titleMark == 1 || compteCourantData?.titleMark == 3 ? "-" + String(compteCourantData?.titleArgent ?? 0) : String(compteCourantData?.titleArgent ?? 0)
              
         }
     }
     
     
     private let labelMark : UILabel = {
         let lbl = UILabel()
         lbl.textColor = .black
         lbl.font = UIFont.boldSystemFont(ofSize: 16)
         lbl.textAlignment = .left
         return lbl
     }()
     
     
     private let labelTypeCompte : UILabel = {
         let lbl = UILabel()
         lbl.textColor = .black
         lbl.font = UIFont.systemFont(ofSize: 16)
         lbl.textAlignment = .left
         lbl.numberOfLines = 0
         return lbl
     }()
    
    private let labelArgent : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        //label.text = "1"
        label.textColor = .black
        return label
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         addSubview(labelMark)
         addSubview(labelTypeCompte)
         addSubview(labelArgent)
        
        labelMark.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        labelTypeCompte.anchor(top: labelMark.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
         let stackView = UIStackView(arrangedSubviews: [labelArgent])
         stackView.distribution = .equalSpacing
         stackView.axis = .horizontal
         stackView.spacing = 5
         addSubview(stackView)
         stackView.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
     }
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 
 
}

