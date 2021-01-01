//
//  ClientData.swift
//  projet
//
//  Created by Hang Nga on 14/12/2020.
//

import Foundation
import UIKit
import CoreData

class ClientData{
    
    static func getAllClientData() -> [ClientModel]{
        var arrData = [ClientModel]()
        
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do {
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                arrData.append(ClientModel(titleNom: result.value(forKey: "nom") as! String, titlePrenom: result.value(forKey: "prenom") as! String, titleTelephone: result.value(forKey: "telephone") as! String, titleId: result.value(forKey: "id") as! Int))
            }
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data
        /*
        arrData = [
        
            ClientModel(titleNom: "test", titlePrenom: "test", titleTelephone: "1234567890", titleId: 2),
            ClientModel(titleNom: "tom", titlePrenom: "cruise", titleTelephone: "0787023751", titleId: 1)
            
        ]
        */
        return arrData
    }
    
}
