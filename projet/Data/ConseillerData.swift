//
//  ConseillerData.swift
//  projet
//
//  Created by Hang Nga on 30/12/2020.
//

import Foundation
import UIKit
import CoreData

class ConseillerData{
    
    static func getAllConseillerData() -> [ConseillerModel]{
        var arrData = [ConseillerModel]()
        arrData = [
        
            ConseillerModel(titleUserName: "admin", titlePassword: "admin", titleId: 1)
            
        ]
        
        return arrData
    }
    
}
