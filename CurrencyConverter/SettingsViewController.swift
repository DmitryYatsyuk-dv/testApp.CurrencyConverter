//
//  SettingsViewController.swift
//  CurrencyConverter
//
//  Created by Lucky on 31.07.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    //MARK: IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
    //MARK: IBActions
    @IBAction func pushCancelAction(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushShowRates(_sender: UIButton) {
        Model.shared.loadXMLFile(date: datePicker.date)
        dismiss(animated: true)
    }
    
    
}
