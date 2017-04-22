//
//  ShopCell.swift
//  SkillupPractice5
//
//  Created by k_motoyama on 2017/04/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit

final class ShopCell: UITableViewCell {
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopThumbnail: UIImageView!
    @IBOutlet weak var nearest: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tell: UILabel!
    @IBOutlet weak var budget: UILabel!
    
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}
