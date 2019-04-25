//
//  ViewController.swift
//  GetDataOnJson
//
//  Created by sun on 24/4/2562 BE.
//  Copyright © 2562 sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    
    struct jsonStruct:Decodable{
        
        let Name:String
        let User:String
        let Password:String
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.DataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as! TableViewCell // cell อ้างอิงจาก TableViewCell.swift
        
        // cell อ้างจาก label ใน TableViewCell.swift
         cell.NameLabel.text = "Password = \(DataArray[indexPath.row].Password)"
         cell.UserLabel.text = "Name = \(DataArray[indexPath.row].Name)"
         cell.PasswordLabel.text = "User = \(DataArray[indexPath.row].User)"
    
        
        return cell
        
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var DataArray = [jsonStruct]() // สร้างตัวแปร = struct
    
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
                let User:String = jsonDictionary["User"] as! String
                let password:String = jsonDictionary["Password"] as! String
                
                let pName = "Name == " + name
                let pUser = "User == " + User
                let pPassword = "Password == " + password
                
                print(pName)
                print(pUser)
                print(pPassword)
                
                print(jsonDictionary)
                
                self.DataArray = try JSONDecoder().decode([jsonStruct].self,from: data!)// ตัวแปรเอาค่าจาก data ไปใส่ใน struct
                
                for jsonData in self.DataArray{
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                    print("\(jsonData.Name) : \(jsonData.User) : \(jsonData.Password)")
                    
                }
                
                print("name ==>> \(name)")
                print("user ==>> \(User)")
                print("password ==> \(password)")
                
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

