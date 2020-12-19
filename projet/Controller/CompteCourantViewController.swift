//
//  CompteCourantViewController.swift
//  projet
//
//  Created by Hang Nga on 17/12/2020.
//

import UIKit

class CompteCourantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var item: ClientComptesModel?
    public var deletionHander: (() ->Void)?
    
    @IBOutlet var table: UITableView!
    private var arrData = [CompteCourantModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
        */
        
        arrData = CompteCourantData.getAllCompteCourantData()
        
        table.register(CompteCourantCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    /*
    @objc private func didTapDelete() {
        guard let item = self.item else {
            return
        }
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompteCourantCell
        
        cell.compteCourantData = arrData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // open screen where we can see item info and delete
        
    }
    
    func refresh() {
        table.reloadData()
    }

}
