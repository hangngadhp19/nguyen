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
    
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        arrData = CompteCourantData.getAllCompteCourantData()
        
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
        
        var headerViews = Dictionary<String, UIView>()
        headerViews["title"] = title
        headerViews["button"] = button

        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[title]-[button]-15-|", options: [], metrics: nil, views: headerViews))
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: [], metrics: nil, views: headerViews))
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button]-|", options: [], metrics: nil, views: headerViews))

    
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
        
        vc.title = "Courant Retirer"
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
        
        vc.title = "Courant Déposer"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
