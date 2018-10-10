//
//  PhotoCollectionViewCell.swift
//  photoApp
//
//  Created by user136368 on 10/10/18.
//  Copyright © 2018 user136368. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblname: UILabel!
    

}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadingImgWithCache(_ urlString: String){
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
        }
    
    
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
