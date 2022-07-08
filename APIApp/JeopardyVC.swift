//
//  JeopardyVC.swift
//  APIApp
//
//  Created by  on 9/22/20.
//  Copyright © 2020 DocsApps. All rights reserved.
//

import UIKit

class JeopardyVC: UIViewController {
    
    // http://jservice.io/api/random
    

    @IBOutlet weak var apiLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    var answer = "Sample Answer"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        displayLabel.text = ""
        answerLabel.text = ""
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        answerLabel.text = answer
    }
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        
        answerLabel.text = ""
        let urlString = "http://jservice.io/api/random"
  
        if let url = URL(string: urlString)
        {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if let err = error {
                    print(err)
                    return
                }

                do {
                    guard let data = data else {return}
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
                    if let jsonData = json {
                        let dictionary = jsonData[0]
                        let theQuestion = dictionary["question"] as? String ?? "clue error"
                        self.answer = dictionary["answer"] as? String ?? "answer error"
                        DispatchQueue.main.async {
                            self.displayLabel.text = theQuestion
                            self.view.endEditing(true)
                        }
                        print(jsonData)
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
            }
            task.resume()
        }
    }
    
    
    
}
