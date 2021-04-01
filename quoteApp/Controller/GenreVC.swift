//
//  GenreVC.swift
//  quoteApp
//
//  Created by Magdalena Toczek on 01/04/2021.
//

import UIKit

class GenreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var quotesManager: QuotesManager?
    var genreList = [String]()

    
    @IBOutlet weak var genreTab: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genreTab.delegate = self
        genreTab.dataSource = self
       
        
        quotesManager?.prepareGenres(completion: { (list) in
            self.updateTableList(list: list) {
                DispatchQueue.main.async  {
                self.genreTab.reloadData()
            }
            }
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as? GenreCell else { return UITableViewCell() }
        
        for _ in genreList {
            cell.genreLBL.text = genreList[indexPath.row]
        }
        return cell
        
    }
 
    
    
    func updateTableList(list: [String], completion: @escaping()->Void){
        self.genreList = list
        completion()
    }
    
    

  

}
