//
//  RatesController.swift
//  CurrencyConverter
//
//  Created by Lucky on 26.07.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class RatesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "StartLoadingXML"),
                                               object: nil, queue: nil) { (notification) in
                                                DispatchQueue.main.async {
                                                    let activityIndicator = UIActivityIndicatorView(style: .large)
                                                    activityIndicator.color = .lightGray
                                                    activityIndicator.startAnimating()
                                                    self.navigationItem.rightBarButtonItem?.customView = activityIndicator
                                                }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RefreshData"),
                                               object: nil, queue: nil) { (notification) in
                                                DispatchQueue.main.async {
                                                    self.tableView.reloadData()
                                                    self.navigationItem.title = Model.shared.currentDate
                                                    let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                                                    self.navigationItem.rightBarButtonItem = barButtonItem
                                                }
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Error loading XML"), object: nil, queue: nil) { (notification) in
            let _ = notification.userInfo?["ErrorName"]
            
            DispatchQueue.main.async {
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
            
        }
        navigationItem.title = Model.shared.currentDate
        Model.shared.loadXMLFile(date: nil)
    }
    
    //MARK: IBActions
    
    @IBAction func pushRefreshAction(_ sender: Any) {
        Model.shared.loadXMLFile(date: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //        guard Model.shared.currencies.count > indexPath.row else { return UITableViewCell() }
        let ratesForCell = Model.shared.currencies[indexPath.row]
        
        cell.textLabel?.text = ratesForCell.Name
        cell.detailTextLabel?.text = ratesForCell.Value
        
        return cell
    }
}
