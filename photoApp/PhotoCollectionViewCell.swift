//
//  PhotoCollectionViewCell.swift
//  photoApp
//
//  Created by user136368 on 10/10/18.
//  Copyright © 2018 user136368. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    //imageView Outlet
    @IBOutlet weak var imageView: UIImageView!
    
}

//setting the image Cache
let imageCache = NSCache<AnyObject, AnyObject>()


extension UIImageView {
    //getting the image at the url and storing it within a local cache.
    func loadingImgWithCache(_ urlString: String){
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
        }
    
        //downloading the image at the given url link
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.main.async(execute:  {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
    
}
