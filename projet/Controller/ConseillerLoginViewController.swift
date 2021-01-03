//
//  ConseillerLoginViewController.swift
//  projet
//
//  Created by Hang Nga on 19/12/2020.
//

import UIKit
import CoreData

class ConseillerLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didCreateConseiller(_ sender: Any) {
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        var id = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Conseiller")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            if result.count > 0 {
                id = result[0].value(forKey: "id") as! Int
            }
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data to get id
        
        // insert data
        let newCompteCourant = NSEntityDescription.insertNewObject(forEntityName: "Conseiller", into: context)
        newCompteCourant.setValue(id + 1, forKey: "id")
        newCompteCourant.setValue("test", forKey: "password")
        newCompteCourant.setValue("test", forKey: "username")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data
    }
    
    @IBAction func didCreateClient(_ sender: Any) {
        // connect db
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        // get data
        var id = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            if result.count > 0 {
                id = result[0].value(forKey: "id") as! Int
            }
        }
        catch let error as NSError {
            print("\(error)")
        }
        // end get data to get id
        
        // insert data
        let newClient = NSEntityDescription.insertNewObject(forEntityName: "Client", into: context)
        newClient.setValue(id + 1, forKey: "id")
        newClient.setValue("tester", forKey: "nom")
        newClient.setValue("client", forKey: "prenom")
        newClient.setValue("8 massena 75013", forKey: "adresse")
        newClient.setValue("1234567890", forKey: "telephone")
        newClient.setValue(1, forKey: "conseiller_id")
        newClient.setValue("8007041149605", forKey: "num_compte")
        newClient.setValue(1000, forKey: "compte_courant_solde")
        newClient.setValue(10, forKey: "compte_livreta_solde")
        newClient.setValue(200, forKey: "compte_epargne_solde")
        newClient.setValue(false, forKey: "is_deleted")
        newClient.setValue(false, forKey: "is_close_compte_livreta")
        newClient.setValue(false, forKey: "is_close_compte_epargne")
        newClient.setValue(Date(), forKey: "created_date")
        newClient.setValue(Date(), forKey: "updated_date")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data
        
        // insert data: compte courant
        let newCompteCourant = NSEntityDescription.insertNewObject(forEntityName: "CompteCourant", into: context)
        newCompteCourant.setValue(1, forKey: "id")
        newCompteCourant.setValue(1, forKey: "type_compte")
        newCompteCourant.setValue(2, forKey: "mark")
        newCompteCourant.setValue(id + 1, forKey: "client_id")
        newCompteCourant.setValue(Date(), forKey: "date_created")
        newCompteCourant.setValue(1000, forKey: "argent")
        newCompteCourant.setValue(false, forKey: "mark_recu")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data: compte courant
        
        // insert data: compte livreta
        let newCompteLivreta = NSEntityDescription.insertNewObject(forEntityName: "CompteLivretA", into: context)
        newCompteLivreta.setValue(1, forKey: "id")
        newCompteLivreta.setValue(2, forKey: "type_compte")
        newCompteLivreta.setValue(2, forKey: "mark")
        newCompteLivreta.setValue(id + 1, forKey: "client_id")
        newCompteLivreta.setValue(Date(), forKey: "date_created")
        newCompteLivreta.setValue(10, forKey: "argent")
        newCompteLivreta.setValue(false, forKey: "mark_recu")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data: compte livreta
        
        // insert data: compte epargne
        let newCompteEpargne = NSEntityDescription.insertNewObject(forEntityName: "CompteEpargne", into: context)
        newCompteEpargne.setValue(1, forKey: "id")
        newCompteEpargne.setValue(3, forKey: "type_compte")
        newCompteEpargne.setValue(2, forKey: "mark")
        newCompteEpargne.setValue(id + 1, forKey: "client_id")
        newCompteEpargne.setValue(Date(), forKey: "date_created")
        newCompteEpargne.setValue(200, forKey: "argent")
        newCompteEpargne.setValue(false, forKey: "mark_recu")
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        // end insert data: compte epargne
    }
    
}
