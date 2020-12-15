//
//  ClientData.swift
//  projet
//
//  Created by Hang Nga on 14/12/2020.
//

import Foundation
import UIKit

class ClientData{
    
    static func getAllClientData() -> [ClientModel]{
        var arrData = [ClientModel]()
        
        arrData = [
        
            ClientModel(titleNom: "nom_user", titlePrenom: "prenom_user", titleTelephone: "0123456789")
            
        ]
        
        return arrData
    }
    
}
