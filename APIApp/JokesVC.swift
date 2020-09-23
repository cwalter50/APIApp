//
//  JokesVC.swift
//  APIApp
//
//  Created by  on 9/22/20.
//  Copyright © 2020 DocsApps. All rights reserved.
//

import UIKit

class JokesVC: UIViewController
{
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayLabel.text = ""
    }
    

    @IBAction func buttonTapped(_ sender: UIButton)
    {
        // Figure out how to make a call to the API
        
        let urlString = "https://official-joke-api.appspot.com/random_joke"
        
        if let url = URL(string: urlString)
        {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                    
                    let setup = json!["setup"] as? String ?? "setup Error"
                    let punchline = json!["punchline"] as? String ?? "punchline Error"
                    DispatchQueue.main.async {
                        self.displayLabel.text = "\(setup)\n\n...\(punchline)"
                        
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }
            task.resume()
        }
    }
    

}
