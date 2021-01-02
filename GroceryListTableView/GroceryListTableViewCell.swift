//
//  GroceryListTableViewCell.swift
//  GroceryListTableView
//
//  Created by changae choi on 2020/12/26.
//

import UIKit

class GroceryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func countButtonTapped(_ sender: Any) {
        
        print("countButtonTapped")
    }
}
