//
//  ClientComptesData.swift
//  projet
//
//  Created by Hang Nga on 17/12/2020.
//

import Foundation
import UIKit
import CoreData

class ClientComptesData{
    
    static func getAllClientComptesData() -> [ClientComptesModel]{
        var arrData = [ClientComptesModel]()
        
        // get id User
        let defaults = UserDefaults.standard
        let idUserLogined = defaults.value(forKey: "idUser")
        // end get id User
        
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "id = %i", idUserLogined as! Int)
        request.predicate = predicate
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            arrData = [
            
                ClientComptesModel(titleNomComptes: "courant", titleNumComptes: result[0].value(forKey: "num_compte") as! String, titleArgentSolde: result[0].value(forKey: "compte_courant_solde") as! Float, titleTypeComptes: 1),
                ClientComptesModel(titleNomComptes: "livreta", titleNumComptes: result[0].value(forKey: "num_compte") as! String, titleArgentSolde: result[0].value(forKey: "compte_livreta_solde") as! Float, titleTypeComptes: 2),
                ClientComptesModel(titleNomComptes: "epargne", titleNumComptes: result[0].value(forKey: "num_compte") as! String, titleArgentSolde: result[0].value(forKey: "compte_epargne_solde") as! Float, titleTypeComptes: 3)
                
            ]
        }
        catch let error as NSError {
            print("\(error)")
        }
        
        return arrData
    }
    
}
