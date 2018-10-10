//
//  ViewController.swift
//  photoApp
//
//  Created by user136368 on 10/10/18.
//  Copyright © 2018 user136368. All rights reserved.
//

import UIKit

struct Img: Decodable {
   let data: [Data]
}

struct Data: Decodable {
    let id: String
    let type: String
    let filter: String
    let link: String
    let images: Imgs
}

struct Imgs: Decodable {
    let standard_resolution: Urls
}

struct Urls: Decodable {
    let url: String
}

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.instagram.com/v1/users/self/media/recent/?access_token=465172273.1677ed0.0413561183774706a2a5ddf38cd564c7"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let images = try JSONDecoder().decode(Img.self, from: data)
                print(images)
            } catch {
                let error = error
                print(error)
            }
        }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

