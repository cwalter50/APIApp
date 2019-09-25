//
//  WeatherVC.swift
//  APIApp
//
//  Created by  on 9/25/19.
//  Copyright © 2019 DocsApps. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var helperLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        myLabel.text = ""
        myTextField.delegate = self
    }
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        myTextField.resignFirstResponder()
        
        let numberString = myTextField.text!
        
         var urlString = "https://www.metaweather.com/api/location/search/?query=london"
//         if numberString != ""
//         {
//             urlString += numberString
//         }
//         else
//         {
//             urlString += "random"
//         }

         
         if let url = URL(string: urlString)
         {
             
             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                 guard let data = data else { return }
                 let result = String(data: data, encoding: .utf8)!
                 print(String(data: data, encoding: .utf8)!)
                 
                 DispatchQueue.main.async {
                     self.myLabel.text = result
                     self.view.endEditing(true)
                 }
             }
             
             task.resume()
             
         }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        
        return true
    }
    

}
