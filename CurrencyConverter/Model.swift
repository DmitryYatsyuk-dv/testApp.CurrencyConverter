//
//  Model.swift
//  CurrencyConverter
//
//  Created by Lucky on 17.07.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

/*
 <NumCode>974</NumCode>
 <CharCode>BYR</CharCode>
 <Nominal>1000</Nominal>
 <Name>Белорусских рублей</Name>
 <Value>18,4290</Value>
*/
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

    static let sharedInstance = Model()
    
    var currencies: [Currency] = []
    
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                       FileManager.SearchPathDomainMask.userDomainMask,
                                                       true)[0] + "/data.xml"
         
        print(path)
        
        return ""
    }
    
    var urlForXML: URL? {
        return nil
    }
    
    // Load data XML <- cbr.ru & save in app catalog
    func loadXMLData(data: Data) {
        <#function body#>
    }
    
    // parse XML & added in array currencies, send notification to the app^ that the data has been updated
    func parseXML() {
        <#function body#>
    }
    
}
