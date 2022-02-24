//
//  AnimalVC.swift
//  APIApp
//
//  Created by Christopher Walter on 2/23/22.
//  Copyright © 2022 DocsApps. All rights reserved.
//

import UIKit
import SDWebImage

class AnimalVC: UIViewController
{

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

      
    }
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        loadRandomAnimal()
        
    }
    
    func loadRandomAnimal()
    {
        displayLabel.text = ""
        let urlString = "https://zoo-animal-api.herokuapp.com/animals/rand"
  
        if let url = URL(string: urlString)
        {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if let err = error {
                    print(err)
                    return
                }
                
                

                do {
                    if let theData = data {
                        let animal = try JSONDecoder().decode(Animal.self, from: theData)
                        
                        print(animal.name)
                        
                        DispatchQueue.main.async {
                            self.displayLabel.text = "\(animal.name)\n\nDiet: \(animal.diet)\nHabitat: \(animal.habitat)"
                            self.myImageView.sd_setImage(with: URL(string: animal.image_link))
                        }
                    }
                    
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
//                    print (json!)
//                    
//                    let dictionary = json![0]
//                    let theQuestion = dictionary["question"] as? String ?? "clue error"
//                    self.answer = dictionary["answer"] as? String ?? "answer error"
//                    DispatchQueue.main.async {
//
//                        self.displayLabel.text = theQuestion
//                        self.view.endEditing(true)
//                    }
                    
//                    print(json!)
                } catch let jsonError {
                    print(jsonError)
                }
                
            }
            task.resume()
        }
    }
    
    

}
