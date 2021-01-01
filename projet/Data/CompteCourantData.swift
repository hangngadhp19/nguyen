//
//  CompteCourantData.swift
//  projet
//
//  Created by Hang Nga on 19/12/2020.
//

import Foundation
import UIKit
import CoreData

class CompteCourantData{
    
    static func getAllCompteCourantData(typeComptes: Int) -> [CompteCourantModel]{
        
        var arrDataCompte = [CompteCourantModel]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        /*
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter
        }()
        */
        
        // get id User
        let defaults = UserDefaults.standard
        let idUserLogined = defaults.value(forKey: "idUser")
        // end get id User
        
        var varEntityName = "CompteCourant"
        
        if typeComptes == 1 {
            varEntityName = "CompteCourant"
        } else if typeComptes == 2 {
            varEntityName = "CompteLivretA"
        } else {
            varEntityName = "CompteEpargne"
        }
        
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: varEntityName)
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "client_id = %i", idUserLogined as! Int)
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do {
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                arrDataCompte.append(CompteCourantModel(titleDateCreated: dateFormatter.date(from: "2020-12-29")!, titleMark: result.value(forKey: "mark") as! Int, titleTypeCompte:result.value(forKey: "type_compte") as! Int, titleArgent: result.value(forKey: "argent") as! Float, titleClientId: result.value(forKey: "client_id") as! Int, titleId: result.value(forKey: "id") as! Int))
            }
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data
        
        return arrDataCompte
    }
    
}
