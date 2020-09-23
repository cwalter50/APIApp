//
//  ViewController.swift
//  APIApp
//
//  Created by  on 9/16/19.
//  Copyright © 2019 DocsApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        numberTextField.delegate = self
        displayLabel.text = ""
        helperLabel.text = "Enter a number or \"random\" for a fact.\n numbersapi.com/\"Number\""
    }
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        // Figure out how to make a call to the API
        let numberString = numberTextField.text!
        
        var urlString = "http://numbersapi.com/"
        if numberString != ""
        {
            urlString += numberString
        }
        else
        {
            urlString += "random"
        }
        if let url = URL(string: urlString)
        {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                let result = String(data: data, encoding: .utf8)!
                print(String(data: data, encoding: .utf8)!)
        
                DispatchQueue.main.async {
                    self.displayLabel.text = result
                    self.view.endEditing(true)
                }
            }
            task.resume()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
}



