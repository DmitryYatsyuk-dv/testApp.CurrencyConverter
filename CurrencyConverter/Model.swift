//
//  Model.swift
//  CurrencyConverter
//
//  Created by Lucky on 17.07.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

var currentCurrency: Currency?
var currentCharacters: String = ""

class Currency {
    
    var NumCode: String?
    var CharCode: String?
    
    var Nominal: String?
    var nominalDouble: Double?
    
    var Name: String?
    
    var Value: String?
    var valueDouble: Double?

}

class Model: NSObject {

    static let shared = Model()
    
    var currencies: [Currency] = []
    
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                       FileManager.SearchPathDomainMask.userDomainMask,
                                                       true)[0] + "/data.xml"
         
        if FileManager.default.fileExists(atPath: path) {
            return path
        }
        
        let bundlePath = Bundle.main.path(forResource: "data", ofType: "xml") ?? "Error"
        return bundlePath
    }
    
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML)
    }
    
    // Load data XML <- cbr.ru & save in app catalog
    func loadXMLData(data: Data) {
    }
    
    // parse XML & added in array currencies, send notification to the app^ that the data has been updated
    func parseXML() {
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self
        parser?.parse()
        
        print(currencies)
    }
}

//MARK: Extn: XMLParserDelegate
extension Model: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "Valute" {
            currentCurrency = Currency()
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentCharacters = string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "NumCode" {
            currentCurrency?.NumCode = currentCharacters
        }
        if elementName == "CharCode" {
            currentCurrency?.CharCode = currentCharacters
        }
        if elementName == "Nominal" {
            currentCurrency?.Nominal = currentCharacters
            currentCurrency?.nominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        if elementName == "Name" {
            currentCurrency?.Name = currentCharacters
        }
        if elementName == "Value" {
            currentCurrency?.Value = currentCharacters
            currentCurrency?.valueDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        if elementName == "Valute" {
//            guard let current = currentCurrency else { return }
            currencies.append(currentCurrency!)
        }
    }
    
}
