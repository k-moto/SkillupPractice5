//
//  AreaViewController.swift
//  SkillupPractice5
//
//  Created by k_motoyama on 2017/04/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

class AreaViewController: UIViewController {

    @IBOutlet weak var areaTable: UITableView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let areaJsonReader = AreaJsonReader()
    let areaTableView = AreaTableView()
    var dataList:[AreaItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areaTable.dataSource = areaTableView
        areaTable.delegate = self
        
        indicatorView.isHidden = false
        indicatorView.isHidden = false
        
        areaJsonReader.loadable = self
        areaJsonReader.parseJsonData()
        
        self.navigationItem.title = "エリア選択"
        
    }
    
}

extension AreaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let shopView = UIStoryboard.viewController(storyboardName: "Shop", identifier: "ShopViewController") as! ShopViewController
        
        shopView.selectPrefCode = dataList[indexPath.row].prefCode
        shopView.selectAreaCodeL = dataList[indexPath.row].areacodeL
        shopView.selectAreaName = dataList[indexPath.row].areanameL

        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        
        self.navigationController?.pushViewController(shopView, animated: true)
        
    }
    
}

extension AreaViewController: AreaLoadable {
    
    func setResult(result: AreaStatus) {
        
        indicatorView.isHidden = true
        indicatorView.isHidden = true
        
        switch result {
            
        case .none:
            showAlert(title: "データ無し", message: "都道府県データが存在しません。")
            
        case .nomal(let result):
            dataList = result.gareaLarge.filter({$0.prefName == "東京都"})
            areaTableView.add(dataList: dataList)
            areaTable.reloadData()
            
        case .noData:
            showAlert(title: "データ無し", message: "都道府県データが存在しません。")
            
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

