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

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    var images = [Data]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = UIScreen.main.bounds.width/3 - 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collectionView.collectionViewLayout = layout
        
        let urlString = "https://api.instagram.com/v1/users/self/media/recent/?access_token=465172273.1677ed0.0413561183774706a2a5ddf38cd564c7"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let images = try JSONDecoder().decode(Img.self, from: data)
                print(images.data)
                for img in images.data {
                    if (img.type == "image"){
                        print(img.type)
                        self.images.append(img)
                       
                    }
                    
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                let error = error
                print(error)
            }
        }.resume()
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
        let img = images[indexPath.item].images.standard_resolution.url
        
        cell.imageView.loadingImgWithCache(img)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

