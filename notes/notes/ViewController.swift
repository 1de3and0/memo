//
//  ViewController.swift
//  notes
//
//  Created by Hidemi Ando on 2015/07/19.
//  Copyright (c) 2015年 Hidemi Ando. All rights reserved.
//

import UIKit





class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource{

    var textField : UITextField?
    
    var listToRemove:Bool = false
    
    var filePaths:NSArray? = nil
    
    var tableView:UITableView? = nil
    
    /// ファイルの保存先
    let directoryPath = NSHomeDirectory().stringByAppendingPathComponent("Documents")
    
    let message_show   = "メモ一覧を表示する"
    let message_create = "メモを作成する"
    let message_remove = "メモを削除する"
    
    let alert_title   = "タイトル"
    let alert_message = "メッセージ"
    let alert_done    = "完了"
    let alert_cancel  = "キャンセル"
    
    let message_succeed = "作成に成功しました"
    let message_failure = "作成に失敗しました"
    let message_no_filename = "ファイル名がありません"
    
    
    let alert_remove     = "選択したファイルを削除してもよろしいですか？"
    let alert_remove_btn = "削除"
    
    let alert_success    = "ファイルの削除に成功しました"
    let alert_failure    = "ファイルの削除に失敗しました"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initPaths()
        // Do any additional setup after loading the view, typically from a nib.
  
        self.title = "メモ帳"
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 右ボタンを作成する..
        let myLeftButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "showAlertToCreateFile")
    
        self.navigationItem.rightBarButtonItem = myLeftButton
    }
    
    // MARK: - Init
    
    func initView() {
        self.title = "ファイル操作"
        
        let frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        tableView = UITableView(frame: frame)
        
      //  tableView.delegate   = self
        tableView!.dataSource = self
        
        self.view.addSubview(tableView!)
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "showAlertToCreateFile")
    }

    
    


    
    
    
//    // MARK: - Get Text
//    
//    func getTextForCell(row:Int) -> String {
//        if (row == 0) {
//            return message_show
//        } else if (row == 1) {
//            return message_create
//        } else {
//            return message_remove
//        }
//    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell =
        UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
       cell.textLabel?.text = getTextForCell(indexPath.row)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (filePaths != nil) {
            return filePaths!.count
        } else {
            return 0
        }
        
        }
    
//     MARK: - UITableViewDelegate
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        
//        if indexPath.row == 0 {
//            showFileList()
//        }
//        else if indexPath.row == 1 {
//            showAlertToCreateFile()
//        }
//        else {
//            showFileListToRemove()
//        }
//    }
//
//
    
  // MARK: - Show AlertController
    /// ファイル名を受け取ってファイルを作成する
    func createFile(fileName:String?) {
        if fileName != nil {
            let fileManager = NSFileManager()
            
            let filePath = directoryPath.stringByAppendingPathComponent(fileName!)
            
            NSLog("createFile %@", filePath)
            
            let fileData = fileName!.dataUsingEncoding(NSUTF8StringEncoding)
            
            if fileManager.createFileAtPath(filePath, contents: fileData, attributes: nil) {
                showAlertMessage("", message: message_succeed)
                
                initPaths()
                
                
              
            } else {
                showAlertMessage("", message: message_failure)
            }
        } else {
            showAlertMessage("", message: message_no_filename)
    }
    

    
    
    
    
    }

    
    
    func onClickMyButton(sender:AnyObject){
        
        let alertController =
        UIAlertController(title: alert_title, message: alert_message, preferredStyle:.Alert)
        
        // このボタンが押されたら{void in}が実行される。{ Void in} はタイムラグが生じる時に使用。
        let otherAction = UIAlertAction(title: alert_done, style: .Default) { Void in
            NSLog("Pressed OK Button. %@", self.textField!.text!)
        }
        
              let cancelAction = UIAlertAction(title: alert_cancel, style: .Cancel) { Void in
            NSLog("Pressed Cancel Button. %@",  self.textField!.text!)
        }
        
        //{ textFiled in~}　textFiledができてから実行される。
    
        alertController.addTextFieldWithConfigurationHandler { textField in
            self.textField = textField
        
            //textField に表示されている灰色の文字
            self.textField!.placeholder = "text input"
           
            self.textField!.delegate = self
        }
        
        //上から順に表示される。
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    


    // MARK: - Show AlertController
    
    /// ファイルを作成するためにUIAlertControllerを表示する
    func showAlertToCreateFile() {
        let alertController =
        UIAlertController(title: alert_title, message: alert_message, preferredStyle:.Alert)
        
        // OKを押したときはファイルを保存する
        let otherAction = UIAlertAction(title: alert_done, style: .Default) { Void in
            self.createFile(self.textField?.text)
        }
        
        // キャンセルを押したときは何もしない
        let cancelAction = UIAlertAction(title: alert_cancel, style: .Cancel) { Void in }
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            self.textField = textField
     //       self.textField!.placeholder = self.placeholder
        }
        
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /// メッセージを表示するためにUIAlertControllerを表示する
    func showAlertMessage(title:String, message:String) {
        let alertController =
        UIAlertController(title: title, message: message, preferredStyle:.Alert)
        
        let otherAction = UIAlertAction(title: alert_done, style: .Default) { Void in }
        
        alertController.addAction(otherAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }


    func saveTextData (text:NSString){
        
        //NSFileManager
        let fileManager = NSFileManager.defaultManager()
        
        fileManager.createFileAtPath("", contents: nil, attributes: nil)
    }
    
    
    /// ファイル一覧を取得する
    func initPaths() {
        let fileManager = NSFileManager.defaultManager()
        
        filePaths = fileManager.contentsOfDirectoryAtPath(directoryPath, error: nil)
        
        // ファイル一覧を更新する
        tableView!.reloadData()
    }
    
    
    
    
    /// テーブルセルの行を取得
    func getTextForCell(row:Int) -> String {
        let fileName = filePaths!.objectAtIndex(row) as! String
        
        return String(format: "%@", fileName)
    }
   
    
    
//    // MARK: - Remove File
//    
//    /// 選択したファイルを削除する
//    func removeFile(row:Int) {
//        let fileName = filePaths?.objectAtIndex(row) as! String
//        
//        let filePath = directoryPath.stringByAppendingPathComponent(fileName)
//        
//        // 削除するファイルをログに出力
//        NSLog("removeFile %@", filePath)
//        
//        if (NSFileManager.defaultManager().removeItemAtPath(filePath, error: nil)) {
//            showAlertMessage("", message: alert_success)
//            initPaths()
//        }
//        else {
//            showAlertMessage("", message: alert_failure)
//        }
//    }
//    
    
}

