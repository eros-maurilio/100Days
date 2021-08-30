//
//  TableViewController.swift
//  WebKitProject
//
//  Created by Eros Maurilio on 30/08/21.
//

import UIKit

class TableViewController: UITableViewController {
    var websites = [(site: "Google", url: "google.com"), (site: "Hacking With Swift", url: "hackingwithswift.com")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "URLs"
        navigationController?.navigationBar.prefersLargeTitles = true

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { websites.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Url", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row].site
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedUrl = websites[indexPath.row].url
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
