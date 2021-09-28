//
//  ViewController.swift
//  Project7
//
//  Created by Eros Maurilio on 23/09/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var filteredWord: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(findPetitions))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        if navigationController?.tabBarItem.tag == 0 {
            
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            
        }
        
        
        if let url = URL(string: urlString) {
            if let  data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the fend; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filterData()
            tableView.reloadData()
        }
    }
    
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
        
    }
    
    @objc func findPetitions() {
        let ac = UIAlertController(title: "Search for a petition", message: "Erite the word you are looking for (leave empty to reset filtering)", preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) {
            [weak self, weak ac] _ in
            self?.filteredWord = ac?.textFields?[0].text ?? ""
            self?.filterData()
            self?.tableView.reloadData()
        })
                     
        present(ac, animated: true)
    }
    
    func filterData() {
        if filteredWord.isEmpty {
            filteredPetitions = petitions
            navigationItem.leftBarButtonItem?.title = "Filter"
            
            return
        }
        
        navigationItem.leftBarButtonItem?.title = "Filer: \(filteredWord)"
        
        filteredPetitions = petitions.filter() { petition in
            
            if let _ = petition.title.range(of: filteredWord, options: .caseInsensitive) { return true }
            
            if let _ = petition.body.range(of: filteredWord, options: .caseInsensitive) { return true }
            
            return false
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { filteredPetitions.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

