//
//  SelectCurrencyController.swift
//  CurrencyConverter
//
//  Created by Lucky on 01.08.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

enum FlagCurrencySelected {
    case from
    case to
}

class SelectCurrencyController: UITableViewController {
    
    //MARK: Variables
    var flagCurrency: FlagCurrencySelected = .from
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: IBActions
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CourseSelectedCell
        
        let currentCurrency: Currency = Model.shared.currencies[indexPath.row]
        cell.initSelectedCell(currency: currentCurrency)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency: Currency = Model.shared.currencies[indexPath.row]
        if flagCurrency == .from {
            Model.shared.fromCurrency = selectedCurrency
        }
        if flagCurrency == .to {
            Model.shared.toCurrency = selectedCurrency
        }
        dismiss(animated: true)
    }
}
