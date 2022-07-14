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
                
                guard let data = data else { return }
                
                do {
                    // convert the data into JSON
                    let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                    print(json)
                    // grab parts of the JSON data
                    let animal = try JSONDecoder().decode(Animal.self, from: data)
                    print(animal.name)
                    
                    DispatchQueue.main.async {
                        self.displayLabel.text = "\(animal.name)\n\nDiet: \(animal.diet)\nHabitat: \(animal.habitat)"
                        self.myImageView.sd_setImage(with: URL(string: animal.image_link))
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }
            task.resume()
        }
    }
    
    

}
