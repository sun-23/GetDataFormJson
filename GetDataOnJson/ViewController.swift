//
//  ViewController.swift
//  GetDataOnJson
//
//  Created by sun on 24/4/2562 BE.
//  Copyright © 2562 sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    
    let aa = ["A","B","C"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return aa.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell =  UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        Cell.textLabel?.text = aa[indexPath.row]
        return Cell
        
    }
    
    
    
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func EnterButton(_ sender: Any) {
        
        let user = userTextField.text!
        getUserWhereUser(user: user)
        
    }
    func getUserWhereUser(user:String) -> Void {
        
        let urlString:String = "https://www.androidthai.in.th/ssm/getUserWhereUserSun.php?isAdd=true&User=\(user)"
        
        guard let url = URL(string: urlString) else {
            print("Have Error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else{
                return
            }
            
            do{
                
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                
                print("jsonResponse ==> \(jsonResponse)")
                
                guard let jsonArray = jsonResponse as? [[String:String]] else{return}
                
                print("jsonArray ==> \(jsonArray)")
                
                let jsonDictionary:Dictionary = jsonArray[0]
                
                
                let name:String = jsonDictionary["Name"] as! String
                let user:String = jsonDictionary["User"] as! String
                let password:String = jsonDictionary["Password"] as! String
                
                
            }catch let myError{
               
                DispatchQueue.main.async {
                     print(myError)
                    self.myAlert(titleString: "User False", messageString: "No \(user) in Database")
                }
                
            }
            
        }
        task.resume()
        
        
    }
    
    func myAlert(titleString:String,messageString:String) -> Void {
        
        let alert = UIAlertController(title: titleString, message: messageString, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert,animated: true,completion: nil)
        
    }


}

