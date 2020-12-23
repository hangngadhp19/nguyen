//
//  ClientEspaceViewController.swift
//  projet
//
//  Created by Hang Nga on 14/12/2020.
//

import UIKit

class ClientEspaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    private var arrData = [ClientComptesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Mes comptes"
        
        // Do any additional setup after loading the view.
        
        arrData = ClientComptesData.getAllClientComptesData()
        
        // table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(ClientEspaceCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClientEspaceCell
        
        //cell.textLabel?.text = arrData[indexPath.row].titleNomComptes
        cell.clientComptesData = arrData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // open screen where we can see item info and delete
        
        let item = arrData[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "comptecourant") as? CompteCourantViewController else {
            return
        }
        
        vc.item = item
        vc.deletionHander = { [weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = item.titleNomComptes
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func refresh() {
        table.reloadData()
    }

}
