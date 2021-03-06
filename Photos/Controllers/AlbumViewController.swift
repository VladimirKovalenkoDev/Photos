//
//  AlbumViewController.swift
//  Photos
//
//  Created by Владимир Коваленко on 04.08.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit


class AlbumViewController: UITableViewController {
   
    
    
    var hitsArray = [PhotoData]()
    var albumTitle = ""
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 383
        downloadData()
        title = albumTitle
        
    }
    

    // MARK: - Table view data source

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return hitsArray.count
       }
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let albumCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        albumCell.userLabel.text = hitsArray[indexPath.row].user
        albumCell.likesLabel.text = String(hitsArray[indexPath.row].likes)
        albumCell.tagsLabel.text = hitsArray[indexPath.row].tags
        if let imageURL = URL(string: hitsArray[indexPath.row].webformatURL) {
            albumCell.spinner.startAnimating()
                   DispatchQueue.global().async {
                       let data = try? Data(contentsOf: imageURL)
                       if let data = data {
                           let image = UIImage(data: data)
                           DispatchQueue.main.async {
                            albumCell.photoImage.image = image
                            if case albumCell.photoImage.image = image {
                                albumCell.spinner.stopAnimating()
                                albumCell.spinner.hidesWhenStopped = true
                            }
                           
                          
                       }
                   }
               }
        
          }
        
        
        return albumCell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photo"{
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! ImageScrollViewController
                destinationVC.imageURL = hitsArray[indexPath.row].webformatURL
                print("Done")
            }
        }
    }
   
    
    
    // MARK: - parsing JSON & getting data
    
    func downloadData() {
    
    let urlString = "https://pixabay.com/api/?key=17753576-e318e14b7839a117254cb5a57&q=\(albumTitle)&image_type=photo&pretty=true"
    let url = URL(string: urlString )
         guard let downloadURL = url else { return }
         URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
             guard let data = data, error == nil, urlResponse != nil else {
                 print("something is wrong")
                 return
             }
             print("downloaded")
             do
             {
                 let decoder = JSONDecoder()
                 let decodeData = try decoder.decode(PixabayData.self, from: data)
                self.hitsArray = decodeData.hits
                 DispatchQueue.main.async {
                     self.tableView.reloadData()
                 }
             } catch {
                 print("something wrong after downloaded")
             }
         }.resume()
     }

}
