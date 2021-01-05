//
//  ClientEspaceCell.swift
//  projet
//
//  Created by Hang Nga on 18/12/2020.
//

import Foundation
import UIKit
class ClientEspaceCell : UITableViewCell {
 
     var clientComptesData : ClientComptesModel? {
         didSet {
            
            labelNomComptes.text = clientComptesData?.titleNomComptes
            labelNumComptes.text = clientComptesData?.titleNumComptes
            labelArgentSolde.text = String(clientComptesData?.titleArgentSolde ?? 0)
            
         }
     }
     
     
     private let labelNomComptes : UILabel = {
         let lbl = UILabel()
         lbl.textColor = .black
         lbl.font = UIFont.boldSystemFont(ofSize: 16)
         lbl.textAlignment = .left
         return lbl
     }()
     
     
     private let labelNumComptes : UILabel = {
         let lbl = UILabel()
         lbl.textColor = .black
         lbl.font = UIFont.systemFont(ofSize: 16)
         lbl.textAlignment = .left
         lbl.numberOfLines = 0
         return lbl
     }()
    
    private let labelArgentSolde : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .systemBlue
        return label
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         addSubview(labelNomComptes)
         addSubview(labelNumComptes)
         addSubview(labelArgentSolde)
        
         labelNomComptes.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
         labelNumComptes.anchor(top: labelNomComptes.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
         let stackView = UIStackView(arrangedSubviews: [labelArgentSolde])
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
