//
//  ViewController.swift
//  photoApp
//
//  Created by user136368 on 10/10/18.
//  Copyright © 2018 user136368. All rights reserved.
//

import UIKit

//Object Structures for unsplash
struct Image: Decodable {
    let id: String
    let urls: Urls
}

struct Urls: Decodable {
    let raw: String
    let full: String
    let regular: String
}

extension URL {
    //getting the initial part of unsplash's url
    private static var baseUrl: String {
        return "https://api.unsplash.com/"
    }
    
    static func with(string: String) -> URL? {
        return URL(string: "\(baseUrl)\(string)")
    }
}


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    var images = [Urls]()
    var selectImage: Urls?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up the layout for the collection view
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collectionView.collectionViewLayout = layout
        
        //getting the JSON object from unsplash
        if let url = URL.with(string: "photos/?page=1") {
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("Client-ID 6a01c6d8243ca73eb28e6c225c2b7de6bea3c5a7d705e14748f66ba64ed19eb9", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    do {
                        //breaking down the JSON data so its readable
                        let images = try JSONDecoder().decode([Image].self, from: data)
                        print(images)
                        for img in images {
                            //saving the data to an array
                            self.images.append(img.urls)
                        }
                        //reloading the view to repopulate it with the data gathered.
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    } catch let error {
                        print(error)
                    }
                }
               
            }.resume()
        }
        
        
        
    }

    //counting the number of items in the array.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //grabbing the collection view cell and setting it to the cell class
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
        let img = images[indexPath.item].regular
        
        //setting the imageview within the cell.
        cell.imageView.loadingImgWithCache(img)
        
        return cell
    }
    
    //cell selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectImage = images[indexPath.item]
        performSegue(withIdentifier: "select", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "select" {
            if let destination = segue.destination as? SelectPhotoViewController {
                destination.selectedImage = selectImage
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

