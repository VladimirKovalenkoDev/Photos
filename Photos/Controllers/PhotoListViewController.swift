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
    
   
   
   
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        
       
        
    }
    
// MARK: - TableViewMethods
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(photoListArray.count)
    return photoListArray.count
    
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
    cell.categoryLabel.text = photoListArray[indexPath.row]
          return cell
   }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAlbum"{
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! AlbumViewController
                destinationVC.albumTitle = photoListArray[indexPath.row]
            }
        }
    }
 
}


 
