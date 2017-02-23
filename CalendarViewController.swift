//  カレンダーを表示するView
//  CalendarViewController.swift
//  Kiroku
//
//  Created by Aoi Sakaue on 2017/02/19.
//  Copyright © 2017年 Sakaue Aoi. All rights reserved.
//

import UIKit

//CALayerクラスのインポート
import QuartzCore

class CalendarViewController: UIViewController{
    
    //TableViewの宣言
    @IBOutlet var tableView : UITableView!

    //UserDefaultsの設定
    var memoArray: [AnyObject] = []
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TableViewCellを使えるようにする
        tableView.register(UINib(nibName: "MemoTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        //取り出すための
        if saveData.array(forKey: "MEMO") != nil {
            memoArray = saveData.array(forKey: "MEMO")! as [AnyObject]
        }
        tableView.delegate? = self as! UITableViewDelegate
        tableView.dataSource? = self as! UITableViewDataSource
        
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Cellの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MemoTableViewCell
        
        //WordList見て直し
        //ID付きのセルを取得する memoArrayから取り出す
        let nowIndexPathDictionary: (AnyObject) =  memoArray[indexPath.row]
        
        cell.MemoLabel.text = nowIndexPathDictionary["memo"] as? String
        cell.DateLabel.text = nowIndexPathDictionary["date"] as? String
        
        return cell
    }

    
    //セルが押されたときに呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if saveData.array(forKey: "MEMO") != nil {
            memoArray = saveData.array(forKey: "MEMO")! as [AnyObject]
            
        }
        
        tableView.reloadData()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
