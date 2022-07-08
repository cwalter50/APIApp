//
//  DadJokesVC.swift
//  APIApp
//
//  Created by Christopher Walter on 7/8/22.
//  Copyright © 2022 DocsApps. All rights reserved.
//

import UIKit

class DadJokesVC: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayLabel.text = ""
    }
    

    @IBAction func buttonTapped(_ sender: UIButton)
    {
        // Create String of URL
        let urlString = "https://icanhazdadjoke.com/"
        
        // Make URL from string
        guard let url = URL(string: urlString) else { return }
    
        // Make a request and add headers. Required from Documentation
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        // Create a URLSessionDataTask, which retrieves content from a URL
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            // make sure we get data back from the
            guard let data = data else { return }
            
            // convert the data into JSON so that we can pull info from it
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
        
            if let jsonData = json {
                print(jsonData)
                let joke = jsonData["joke"] as? String ?? "No Joke Found"
                // Needed to update UI Items on a background thread.
                DispatchQueue.main.async {
                    self.displayLabel.text = joke
                }
            }
        }
        // .resume() starts the actual URLSessionDataTask that was created above.
        task.resume()
    }

}
