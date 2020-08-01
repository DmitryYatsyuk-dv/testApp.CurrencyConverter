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
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFrom.delegate = self
//        setupTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons()
        textFromEditingChange(self)
        labelRateForDate.text = Model.shared.currentDate
        navigationItem.rightBarButtonItem = nil
    }
    
    //MARK: IBActions
    
    @IBAction func pushFromAction(_ sender: Any) {
        let navigationC = storyboard?.instantiateViewController(identifier: "SelectedCurrencyID") as! UINavigationController
        navigationC.modalPresentationStyle = .fullScreen
        (navigationC.viewControllers[0] as! SelectCurrencyController).flagCurrency = .from
        present(navigationC, animated: true, completion: nil)
    }
    
    @IBAction func pushToAction(_ sender: Any) {
        let navigationC = storyboard?.instantiateViewController(identifier: "SelectedCurrencyID") as! UINavigationController
        navigationC.modalPresentationStyle = .fullScreen
        (navigationC.viewControllers[0] as! SelectCurrencyController).flagCurrency = .to
        present(navigationC, animated: true, completion: nil)
    }
    
    
    @IBAction func textFromEditingChange(_ sender: Any) {
        
        let amount = Double(textFrom.text!)
        if amount != nil {
            textTo.text = Model.shared.converter(amount: amount)
        }
    }
    
    @IBAction func pushDoneAction(_ sender: Any) {
        textFrom.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        
    }
    
//    fileprivate func setupTapGesture() {
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlehandleTapDismiss)))
//    }
//
//    @objc fileprivate func handlehandleTapDismiss() {
//        self.view.endEditing(true)
//    }
    
    func refreshButtons() {
        
        buttonFrom.setTitle(Model.shared.fromCurrency.CharCode, for: .normal)
        buttonTo.setTitle(Model.shared.toCurrency.CharCode, for: .normal)
    }
}

//MARK: extension TextField
extension ConverterController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = buttonDone
        return true
    }
    
    
}
