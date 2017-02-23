//  情報を登録するView
//  KirokuViewController.swift
//  Kiroku
//
//  Created by Aoi Sakaue on 2017/02/19.
//  Copyright © 2017年 Sakaue Aoi. All rights reserved.
//
//, UITableViewDataSource ,UITableViewDelegate
import UIKit

class KirokuViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var Datelabel: UILabel!
    @IBOutlet var Memolabel: UILabel!
    
    @IBOutlet var MemoTextField: UITextField!
    @IBOutlet var DateTextField: UITextField!
    @IBOutlet var OKButton: UIButton!
    
    
    //TableViewの宣言
    @IBOutlet var tableView : UITableView!

    //UserDefaultsの設定
    var memoArray: [AnyObject] = []
    let saveData = UserDefaults.standard
    
    //現在の日付取得
    let nowDate = Date()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    //キーパッドのツールバー
    var toolBar:UIToolbar!
    
    
// Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()

        //取り出すための
//        if saveData.array(forKey: "MEMO") != nil {
//            memoArray = saveData.array(forKey: "MEMO")! as [AnyObject]
//            
//        }
        
        
        //日付フィールドの設定
        dateFormat.dateFormat = "yyyy年MM月dd日"
        DateTextField.text = dateFormat.string(from: nowDate)
        self.DateTextField.delegate = self
        
        // DatePickerの設定(日付用)
        inputDatePicker.datePickerMode = UIDatePickerMode.date
        DateTextField.inputView = inputDatePicker

        
        // キーボードに表示するツールバーの表示
        //ツールバーの高さと幅
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        //ツールバーの位置を指定
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black

        //ツールバーにボタンを表示
        let toolBarButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(KirokuViewController.doneButton))
        toolBar.items = [toolBarButton]
        DateTextField.inputAccessoryView = toolBar
        MemoTextField.inputAccessoryView = toolBar
        
        //ボタンの設定
        //右寄せのためのスペース設定
         _ = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,target: self,action: nil)
        toolBar.sizeToFit()

        //キーボード、ぴっかーについてくる
        MemoTextField.inputAccessoryView = toolBar
        DateTextField.inputAccessoryView = toolBar
        
//        //画面タップでキーボードを隠す
//        let singleTap = UITapGestureRecognizer(target: self, action: #selector(KirokuViewController.onTap(_:)))
//        singleTap.numberOfTapsRequired = 1
//        view.addGestureRecognizer(singleTap)
 
        }
    
    
    //タップで隠す
    func onTap (_ recognizer:UIPanGestureRecognizer){
        MemoTextField.resignFirstResponder()
        DateTextField.resignFirstResponder()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //toolbarのdoneボタン
    func doneButton(){
        DateTextField.resignFirstResponder()
        MemoTextField.resignFirstResponder()
        toolBarBtnPush()
    }

    //完了を押すとピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
    func toolBarBtnPush(){
        
        let pickerDate = inputDatePicker.date
        DateTextField.text = dateFormat.string(from: pickerDate)
        
        self.view.endEditing(true)
    }
    
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//        return cell!
//        cell.dateLabel.text =
//    }
    
    
    
    //保存ボタンが呼ばれたときに
    @IBAction func save() {
        let memo = ["memo":MemoTextField.text!,"date":DateTextField.text!]
        
        memoArray.append(memo as AnyObject)
        
        saveData.set(memoArray, forKey: "MEMO")
        
        
        //予定を保存した時にアラートを表示
        let alert = UIAlertController(
            title: "保存完了",
            message: "保存が完了しました",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler:nil
            )
        )
        self.present(alert, animated: true, completion:nil)
        
        MemoTextField.text = ""
        DateTextField.text = ""
        
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
