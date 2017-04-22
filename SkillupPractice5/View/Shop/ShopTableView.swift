//
//  ShopTableViewCell.swift
//  SkillupPractice5
//
//  Created by k_motoyama on 2017/04/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit

class ShopTableView: NSObject, UITableViewDataSource {
    
    var shopList: [ShopItem] = []
    
    func add(shopList: [ShopItem]){
        self.shopList = shopList
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.identifier,for: indexPath) as! ShopTableViewCell
        
        let shopItem = shopList[indexPath.row]
        
        cell.shopName.text = shopItem.name
        
        
        if let url = URL.init(string: shopItem.shopImage1) {
            cell.shopThumbnail.af_setImage(withURL: url)
            
        } else {
            cell.shopThumbnail.image = UIImage(named:"noimage")
            
        }
        
        let nearest =  "\(shopItem.station)　\(shopItem.walk)分"
        
        cell.nearest.text = nearest
        
        cell.address.text = shopItem.address
        cell.tell.text = shopItem.tel
        
        if let dispBudget = Int(shopItem.budget) {
            cell.budget.text = "¥\(dispBudget.decimalStr)"
        }
        
        
        
        return cell
    }
    
}
