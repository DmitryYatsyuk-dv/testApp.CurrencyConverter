//
//  Model.swift
//  CurrencyConverter
//
//  Created by Lucky on 17.07.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

//MARK: Variables

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
    var currentDate: String = ""
    
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
    
    //MARK: LoadXMLFile
    // Load data XML <- cbr.ru & save in app catalog
    // http://www.cbr.ru/scripts/XML_daily.asp?
    
    func loadXMLFile(date: Date?) {
        
        var strURL = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
        
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            strURL = strURL + dateFormatter.string(from: date!)
        }
        
        guard let url = URL(string: strURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                               FileManager.SearchPathDomainMask.userDomainMask,
                                                               true)[0] + "/data.xml"
                let urlForSave = URL(fileURLWithPath: path)
                
                do {
                    try data?.write(to: urlForSave)
                    print("File downloaded")
                    self.parseXML()
                    
                } catch {
                    print("Error save data: \(error.localizedDescription)")
                }
                
            } else {
                let error = error ?? "" as! Error
                print("\(error.localizedDescription), Error func_loadXMLData")
            }
        }
        
        task.resume()
    }
    
    //MARK: ParseXML
    // parse XML & added in array currencies, send notification to the app^ that the data has been updated
    
    func parseXML() {
        currencies = []
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self
        parser?.parse()
        print("Data updated")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RefreshData"), object: self)
    }
}

//MARK: Extn: XMLParserDelegate
extension Model: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "ValCurs" {
            
            if let currentDateStr = attributeDict["Date"] {
                currentDate = currentDateStr
            }
            
        }
        
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
            
            currencies.append(currentCurrency!)
        }
    }
    
}
