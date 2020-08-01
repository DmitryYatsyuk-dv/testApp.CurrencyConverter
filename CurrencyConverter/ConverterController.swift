//
//  ConverterController.swift
//  CurrencyConverter
//
//  Created by Lucky on 01.08.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var labelRateForDate: UILabel!
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonTo: UIButton!
    @IBOutlet weak var textFrom: UITextField!
    @IBOutlet weak var textTo: UITextField!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          refreshButtons()
      }
    
    //MARK: IBActions
    
    @IBAction func pushFromAction(_ sender: Any) {}
    
    @IBAction func pushToAction(_ sender: Any) {}
    
    
    @IBAction func textFromEditingChange(_ sender: Any) {
        
        let amount = Double(textFrom.text!)
        if amount != nil {
            textTo.text = Model.shared.converter(amount: amount)
        }
    }
    
    func refreshButtons() {
        
        buttonFrom.setTitle(Model.shared.fromCurrency.CharCode, for: .normal)
        buttonTo.setTitle(Model.shared.toCurrency.CharCode, for: .normal)
    }
    
    
    
}
