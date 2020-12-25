//
//  CourantDeposerViewController.swift
//  projet
//
//  Created by Hang Nga on 23/12/2020.
//

import UIKit
// import SQLite

class CourantDeposerViewController: UIViewController {
/*
    var database: Connection!
    
    let compteCourantTable = Table("CompteCourant")
    let id = Expression<Int>("id")
    let client_id = Expression<Int>("client_id")
    let argent = Expression<Int>("argent")
    let mark = Expression<Int>("mark")
    let type_compte = Expression<Int>("type_compte")
    let date_created = Expression<Date>("date_created")
*/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
/*
        do {
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("CompteCourant").appendingPathExtension("sqlite3")
            
            let database = try Connection(fileUrl.path)
            self.database = database
            
            createTable()
            
        } catch {
            print(error)
        }
*/
    }
/*
    @IBAction func createTable() {
        print ("Create Table")
        
        let createTable = self.compteCourantTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.client_id)
            table.column(self.argent)
            table.column(self.mark)
            table.column(self.type_compte)
            table.column(self.date_created)
        }
        
        do {
            try self.database.run(createTable)
            print ("Created table")
        } catch {
            print (error)
        }
        
    }
*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
