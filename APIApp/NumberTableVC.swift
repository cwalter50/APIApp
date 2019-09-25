//
//  NumberTableVC.swift
//  APIApp
//
//  Created by  on 9/18/19.
//  Copyright © 2019 DocsApps. All rights reserved.
//

import UIKit

class NumberTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var facts: [Fact] = [Fact]()

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        loadFacts()
    }
    
    func loadFacts()
    {
        
        for i in -5...50
        {
            var urlString = "http://numbersapi.com/"
            urlString += "\(i)"
            if let url = URL(string: urlString)
            {
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    guard let data = data else { return }
                    let result = String(data: data, encoding: .utf8)!
                    print(String(data: data, encoding: .utf8)!)
                    
                    let newFact = Fact(number: i, fact: result)
                    DispatchQueue.main.async {
                        self.facts.append(newFact)
                        // sort facts
                        self.facts.sort
                        {
                            $0.number < $1.number
                        }
                        self.myTableView.reloadData()
                    }
                }
                
                task.resume()
                
            }
        }
        
        
//        if numberString != ""
//        {
//            urlString += numberString
//        }
//        else
//        {
//            urlString += "random"
//        }
        
        
        
    }
    
    // MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let fact = facts[indexPath.row]
        cell.textLabel?.text = "\(fact.fact)"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
