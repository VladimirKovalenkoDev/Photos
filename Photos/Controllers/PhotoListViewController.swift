//
//  PhotoListViewController.swift
//  Photos
//
//  Created by Владимир Коваленко on 03.08.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController,UITableViewDataSource {
    var photoListArray =  ["Mountain","Forest","Cars","Flowers","People","Dogs","Cats","Children","Friends","Family","Food","Love","War","Peace","Football","Paris","Moscow","Rome","Wachington","Fishing","London","Work","Carnaval","Space","Earth","Moon","School"]
    
    var hitsArray = [PhotoData]()
   
   
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.reloadData()
        tableView.rowHeight = 85.0
        
    }
    
// MARK: - TableViewMethods
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(photoListArray.count)
    return photoListArray.count
    
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
    cell.categoryLabel.text = photoListArray[indexPath.row]
    
   
        /* if let imageURL = URL(string: hitsArray[indexPath.row].previewURL) {
                     DispatchQueue.global().async {
                         let data = try? Data(contentsOf: imageURL)
                         if let data = data {
                             let image = UIImage(data: data)
                             DispatchQueue.main.async {
                              cell.previewImage.image = image
                                self.downloadData(with: self.photoListArray[indexPath.row])
                         }
                     }
                 }
          
            }*/
          return cell
   }
    
 
}

// MARK: - parsing JSON & getting data
extension PhotoListViewController {
    func downloadData(with string: String) {
        let urlString = "https://pixabay.com/api/?key=17753576-e318e14b7839a117254cb5a57&q=\(string)&image_type=photo&pretty=true"
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
                        print(self.hitsArray)
                     }
                 } catch {
                     print("something wrong after downloaded")
                 }
             }.resume()
         }
}

 
