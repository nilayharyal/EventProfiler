//
//  EventsCustomTableViewCell.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/26/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit

class EventsCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var eventDetailsView: UIView!
    
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var eventVenueLabel: UILabel!
    
    @IBOutlet weak var eventStartDateLabel: UILabel!
    
    @IBOutlet weak var eventPriceRangeLabel: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
