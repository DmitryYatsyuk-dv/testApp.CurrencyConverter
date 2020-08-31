//
//  CourseSelectedCell.swift
//  CurrencyConverter
//
//  Created by Lucky on 31.08.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class CourseSelectedCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelNameCurrencies: UILabel!
    
    func initSelectedCell(currency:Currency) {
        imageFlag.image = currency.imageFlag
        labelNameCurrencies.text = currency.Name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
