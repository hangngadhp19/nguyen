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
    
    public var typeComptesPass = 1
    
    public var titleNomComptes = "courant"
    
    @IBOutlet var table: UITableView!
    private var arrData = [CompteCourantModel]()
    
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        arrData = CompteCourantData.getAllCompteCourantData(typeComptes: typeComptesPass)
        
        table.register(CompteCourantCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
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
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height))
        headerView.backgroundColor = UIColor.link
        
        if typeComptesPass == 1 {
        
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = "Déposer"
            let tap = UITapGestureRecognizer(target: self, action: #selector(CompteCourantViewController.titleClickedDeposer))
            title.isUserInteractionEnabled = true
            title.addGestureRecognizer(tap)
            title.textColor = .white
            title.font = UIFont.boldSystemFont(ofSize: 16)
            headerView.addSubview(title)
        
            
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Retirer", for: .normal)
            button.addTarget(self,action:#selector(buttonClickedRetirer),for:.touchUpInside)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            headerView.addSubview(button)
            
            let button1 = UIButton(type: .system)
            button1.translatesAutoresizingMaskIntoConstraints = false
            button1.setTitle("Virement", for: .normal)
            button1.addTarget(self,action:#selector(buttonClickedVirer),for:.touchUpInside)
            button1.setTitleColor(.white, for: .normal)
            button1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            headerView.addSubview(button1)
            
            var headerViews = Dictionary<String, UIView>()
            headerViews["title"] = title
            headerViews["button"] = button
            headerViews["button1"] = button1

            headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[title]-[button1]-55-[button]-15-|", options: [], metrics: nil, views: headerViews))
            headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: [], metrics: nil, views: headerViews))
            headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button1]-|", options: [], metrics: nil, views: headerViews))
            headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button]-|", options: [], metrics: nil, views: headerViews))
        } else {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = ""
            let tap = UITapGestureRecognizer(target: self, action: #selector(CompteCourantViewController.titleClickedDeposer))
            title.isUserInteractionEnabled = true
            title.addGestureRecognizer(tap)
            title.textColor = .white
            title.font = UIFont.boldSystemFont(ofSize: 16)
            headerView.addSubview(title)
            
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Virement", for: .normal)
            button.addTarget(self,action:#selector(buttonClickedVirer),for:.touchUpInside)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            headerView.addSubview(button)
            
            var headerViews = Dictionary<String, UIView>()
            headerViews["title"] = title
            headerViews["button"] = button

            headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[title]-[button]-15-|", options: [], metrics: nil, views: headerViews))
            headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: [], metrics: nil, views: headerViews))
            headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button]-|", options: [], metrics: nil, views: headerViews))
        }
        
        return headerView
    }
    
    @objc func buttonClickedRetirer(sender:UIButton)
    {
        guard let vc = storyboard?.instantiateViewController(identifier: "courant_retirer") as? CourantRetirerViewController else {
            return
        }
        
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        
        let parNomComptes = titleNomComptes
        
        vc.title = "\(parNomComptes) Retirer"
        
        var varTypeCompte = 1
        if parNomComptes == "courant" {
            varTypeCompte = 1
        } else if parNomComptes == "livreta" {
            varTypeCompte = 2
        } else {
            varTypeCompte = 3
        }
        
        vc.selectedTypeCompte = varTypeCompte
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleClickedDeposer(sender:UITapGestureRecognizer) {
        guard let vc = storyboard?.instantiateViewController(identifier: "courant_deposer") as? CourantDeposerViewController else {
            return
        }
        
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        
        let parNomComptes = titleNomComptes
        
        vc.title = "\(parNomComptes) Déposer"
        
        var varTypeCompte = 1
        if parNomComptes == "courant" {
            varTypeCompte = 1
        } else if parNomComptes == "livreta" {
            varTypeCompte = 2
        } else {
            varTypeCompte = 3
        }
        
        vc.selectedTypeCompte = varTypeCompte
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func buttonClickedVirer(sender:UIButton)
    {
        guard let vc = storyboard?.instantiateViewController(identifier: "virement") as? VirerViewController else {
            return
        }
        
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        
        var parNomComptes = "courant"
        if typeComptesPass == 1 {
            parNomComptes = "courant"
        } else if typeComptesPass == 2 {
            parNomComptes = "livreta"
        } else {
            parNomComptes = "epargne"
        }
        
        vc.title = "\(parNomComptes) Virement"
        
        var varTypeCompte = 1
        if parNomComptes == "courant" {
            varTypeCompte = 1
        } else if parNomComptes == "livreta" {
            varTypeCompte = 2
        } else {
            varTypeCompte = 3
        }
        
        vc.selectedTypeCompte = varTypeCompte
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
