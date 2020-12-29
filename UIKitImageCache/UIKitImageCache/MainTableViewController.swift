//
//  MainTableViewController.swift
//  CacheImageTest
//
//  Created by Rob Kerr on 12/27/20.
//

import UIKit

struct CellData {
    let imageUrl:String
    let placeholderImage:UIImage?
    let errorImage:UIImage?    
}

class MainTableViewController: UITableViewController {
    
    var cellData = [CellData]()
    let errorImage = UIImage(named: "error")
    let placeholderImage = UIImage(named: "hourglass")
    
    let imageUrls = [
        "https://www.robkerr.com/content/images/2020/12/news.jpg",
        "https://www.robkerr.com/content/images/2020/12/architecture.jpg",
        "https://www.robkerr.com/content/images/2020/12/noSuchImageOnServer.jpg",
        "https://www.robkerr.com/content/images/2020/12/design.jpg",
        
        "https://www.robkerr.com/content/images/2020/12/news.jpg",
        "https://www.robkerr.com/content/images/2020/12/architecture.jpg",
        "https://www.robkerr.com/content/images/2020/12/noSuchImageOnServer.jpg",
        "https://www.robkerr.com/content/images/2020/12/design.jpg"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableData()
    }

    private func loadTableData() {
        for url in imageUrls {
            cellData.append(CellData(imageUrl: url,
                                     placeholderImage: placeholderImage,
                                     errorImage: errorImage))
        }
    }
    
    @IBAction func refreshControlValueChanged(_ sender: UIRefreshControl) {

        // Uncomment this line to cause all images to be re-fetched from
        // network on every pull/refresh (only for testing, do not do this for prod)
        //imageCache.removeAllObjects()
        
        // Clear the tableview prior to the delay. Remove for production app
        cellData.removeAll()
        tableView.reloadData()
        
        // This artificial 1 second delay is only to demonstrate a state
        // change in the tableview prior to reload. In a productino
        // app this should be removed.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadTableData()
            self.tableView.reloadData()
            
        }
        
        sender.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let obj = cellData[indexPath.row]

        if let imageView = cell.viewWithTag(1) as? UIImageView {
            
            let method:FetchMethod = indexPath.row < 3 ? .nsCache : .urlCache
            
            imageView.loadImage(urlString: obj.imageUrl,
                                placeholderImage: obj.placeholderImage,
                                errorImage: obj.errorImage, fetchMethod: method)
        }

        return cell
    }
}
