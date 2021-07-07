//
//  ViewController.swift
//  JSON Parsing
//
//  Created by Mac on 05/05/2021 / india.
//

import UIKit

struct Post: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class ViewController: UIViewController {
    
    var postArray: [Post] = []

    @IBOutlet weak var postTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        
    }

    func parseJson() {
        let str = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.postArray = try JSONDecoder().decode([Post].self, from: data!)
                    DispatchQueue.main.async {
                        self.postTable.reloadData()
                    }
                } catch {
                    print("Something went wrong")
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let Post = postArray[indexPath.row]
        cell?.textLabel?.text = Post.title
        cell?.detailTextLabel?.text = Post.body
        return cell!
    }
    
    
}
