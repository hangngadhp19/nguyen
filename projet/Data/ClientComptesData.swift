//
//  ClientComptesData.swift
//  projet
//
//  Created by Hang Nga on 17/12/2020.
//

import Foundation
import UIKit

class ClientComptesData{
    
    static func getAllClientComptesData() -> [ClientComptesModel]{
        var arrData = [ClientComptesModel]()
        
        arrData = [
        
            ClientComptesModel(titleNomComptes: "Compte Courrant", titleNumComptes: "7707427", titleArgentSolde: 10000),
            ClientComptesModel(titleNomComptes: "Compte Livret A", titleNumComptes: "7707427", titleArgentSolde: 20000),
            ClientComptesModel(titleNomComptes: "Compte Épargne", titleNumComptes: "7707427", titleArgentSolde: 30000)
            
        ]
        
        return arrData
    }
    
}
