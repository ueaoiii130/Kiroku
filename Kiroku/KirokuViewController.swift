//  情報を登録するView
//  KirokuViewController.swift
//  Kiroku
//
//  Created by Aoi Sakaue on 2017/02/19.
//  Copyright © 2017年 Sakaue Aoi. All rights reserved.
//

import UIKit

class KirokuViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var datelabel: UILabel!
    @IBOutlet var memolabel: UILabel!
    
    @IBOutlet var memoTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!

    //UserDefaultsの設定
    var memoArray: [[String: String]] = []
    let saveData = UserDefaults.standard
    
    //現在の日付取得
    let nowDate = Date()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        //取り出すための
        if saveData.array(forKey: "MEMO") != nil {
            memoArray = saveData.array(forKey: "MEMO") as! [[String: String]]
        }
        
        //日付フィールドの設定
        dateFormat.dateFormat = "yyyy年MM月dd日"
        dateTextField.text = dateFormat.string(from: nowDate)
        dateTextField.delegate = self
        
        // DatePickerの設定(日付用)
        inputDatePicker.datePickerMode = UIDatePickerMode.date
        dateTextField.inputView = inputDatePicker

        
        // キーボードに表示するツールバーの表示
        //ツールバーの高さと幅
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        //ツールバーの位置を指定
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        //キーボード、ピッカーにくっつく
        dateTextField.inputAccessoryView = toolBar
        memoTextField.inputAccessoryView = toolBar

        //ツールバーにボタンを表示
        let toolBarButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(doneButton))
        toolBar.items = [toolBarButton]
        
        //ボタンの設定
        //右寄せのためのスペース設定
         _ = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,target: self,action: nil)
        toolBar.sizeToFit()

    }
    
    //タップで隠す
    func onTap (_ recognizer: UIPanGestureRecognizer){
        self.view.endEditing(true)
    }
    
    //toolbarのdoneボタン
    func doneButton(){
        self.view.endEditing(true)
        toolBarBtnPush()
    }

    //完了を押すとピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
    func toolBarBtnPush(){
        
        let pickerDate = inputDatePicker.date
        dateTextField.text = dateFormat.string(from: pickerDate)
        
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //保存ボタンが呼ばれたときに
    @IBAction func save() {
        let memo = ["memo": memoTextField.text!,"date": dateTextField.text!]
        
        memoArray.append(memo)
        
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
        
        memoTextField.text = ""
        dateTextField.text = ""
        
    }
}
