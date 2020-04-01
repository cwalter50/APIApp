//
//  FOffVC.swift
//  APIApp
//
//  Created by Christopher Walter on 3/31/20.
//  Copyright © 2020 DocsApps. All rights reserved.
//

import UIKit

class FOffVC: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fOffButton: UIButton!
    
    var name = "Doc"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func fOffButtonTapped(_ sender: UIButton) {
        
        if nameTextField.text != ""
        {
            name = nameTextField.text!
        }
        else
        {
            name = "Doc"
        }
        let urlString = "http://foaas.com/programmer/\(name)"
                if let url = URL(string: urlString)
                {
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                                
                         guard let data = data else { return }
                         let result = String(data: data, encoding: .utf8)! // this is the String of the data. // The result came up as HTML...
                         print(String(data: data, encoding: .utf8)!)
                        
                                
                         // do stuff with the data
                         DispatchQueue.main.async {
                              // do stuff to the ui like update a label etc.  All that must be done on the main thread.
                            
                            // this snippet will convert HTML data to attributed string.
                            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                                self.resultLabel.attributedText = attributedString
                            }
        //                    self.resultLabel.text = result
                         }
                     }
                     task.resume()
                 }
        
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
