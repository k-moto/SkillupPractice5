//
//  ShopViewController.swift
//  SkillupPractice5
//
//  Created by k_motoyama on 2017/04/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import AlamofireImage
import STV_Extensions

class ShopViewController: UIViewController {
    
    @IBOutlet weak var shopTable: UITableView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let shopAPI = ShopAPI()
    var selectPrefCode = ""
    var selectAreaCodeL = ""
    var selectAreaName = ""
    
    var hitCount: String = "0"
    var shopList: [ShopItem] = []
    
    var pageCount = 1
    var currentDate = Date()
    
    let shopTableView :ShopTableView = ShopTableView()
    
    
    override func viewDidLoad() {
        shopTable.dataSource = shopTableView
        shopTable.delegate = self
        
        shopTable.estimatedRowHeight = 45
        shopTable.rowHeight = UITableViewAutomaticDimension
        
        indicatorView.isHidden = false
        indicator.isHidden = false
        shopAPI.loadable = self
        shopAPI.fetch(areaCodeL: selectAreaCodeL, pref: selectPrefCode, perPage: "50", offset: pageCount)
        self.navigationItem.title = selectAreaName + "の飲食店 0件"
    }
    
    
}

extension ShopViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if shopTable.contentOffset.y + shopTable.frame.size.height > shopTable.contentSize.height && shopTable.isDragging {
            
            let calendar = Calendar(identifier: .gregorian)
            let difference = calendar.dateComponents([.second], from: currentDate, to: Date()).second!
            
            if difference > 1 {
                indicatorView.isHidden = false
                shopAPI.loadable = self
                pageCount += 1
                shopAPI.fetch(areaCodeL: selectAreaCodeL, pref: selectPrefCode, perPage: "50", offset: pageCount)
                currentDate = Date()
            }
            
        }
    }
}


extension ShopViewController: ShopLoadable {
    
    func setResult(result: ShopStatus) {
        
        indicatorView.isHidden = true
        indicator.isHidden = true
        
        switch result {
            
        case .none:
            showAlert(title: "データ無し", message: "飲食店データが存在しません。")
            
        case .nomal(let result):
            shopList += result.rest
            shopTableView.add(shopList: shopList)
            shopTable.reloadData()
            if let dispHitCount = Int(result.hitCount) {
                self.navigationItem.title = selectAreaName + "の飲食店 \(dispHitCount.decimalStr)件"
            }

            
        case .noData:
            showAlert(title: "データ無し", message: "飲食店データが存在しません。")
            
        case .error(let error):
            showAlert(title: "エラー", message: "何らかのエラーが発生しました。")
            
            print("error: \(error)")
        }
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
