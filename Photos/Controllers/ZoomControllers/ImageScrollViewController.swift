//
//  ImageScrollViewController.swift
//  Photos
//
//  Created by Владимир Коваленко on 06.08.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class ImageScrollViewController: UIViewController {

    var imageScrollView: ImageScroll!
     var imageURL = ""
     override func viewDidLoad() {
         super.viewDidLoad()
         
         
         imageScrollView = ImageScroll(frame: view.bounds)
         view.addSubview(imageScrollView)
         setupImageScrollView()
         if let imageURL = URL(string: imageURL) {
              DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                             let urlContents = try? Data(contentsOf: imageURL)
                             
                             DispatchQueue.main.async {
                                 if let imageData = urlContents {
                                     if let image = UIImage(data: imageData){
                                          self?.imageScrollView.set(image: image )
                                         print("Done!!!")
                                     }

                                 }
                             }
                             
                         }
         
           }

     }
     
    
     func setupImageScrollView() {
         imageScrollView.translatesAutoresizingMaskIntoConstraints = false
         imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
         imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
         imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
     }
    


}
