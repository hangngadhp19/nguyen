//
//  CompteCourantData.swift
//  projet
//
//  Created by Hang Nga on 19/12/2020.
//

import Foundation
import UIKit

class CompteCourantData{
    
    static func getAllCompteCourantData() -> [CompteCourantModel]{
        var arrDataCompte = [CompteCourantModel]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        arrDataCompte = [
        
            CompteCourantModel(titleDateCreated: dateFormatter.date(from: "2020-12-12")!, titleMark: 1, titleTypeCompte: 1, titleArgent: 100.23),
            CompteCourantModel(titleDateCreated: dateFormatter.date(from: "2020-12-22")!, titleMark: 2, titleTypeCompte: 2, titleArgent: 200.87),
            CompteCourantModel(titleDateCreated: dateFormatter.date(from: "2020-12-28")!, titleMark: 3, titleTypeCompte: 3, titleArgent: 540)
            
        ]
        
        return arrDataCompte
    }
    
}
