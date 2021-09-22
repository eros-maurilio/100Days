//
//  ViewController.swift
//  ShoppingListConsolidation3
//
//  Created by Eros Maurilio on 22/09/21.
//

import UIKit

class ViewController: UITableViewController {
    var list = [String]()
    var cellId = "Cell"
    var isAdding = false
    private lazy var button: UIButton = {
        let btn = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .large)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: config), for: .normal)
        btn.addTarget(self, action: #selector(promptForAdd), for: .touchUpInside)
        
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareSheet))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
        
        view.addSubview(button)
        
        let constraint = [
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { list.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    @objc func promptForAdd() {
        let ac = UIAlertController(title: "Enter an Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.add(item)
        }
        
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    func add(_ item: String) {
        list.insert(item, at: 0)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func clearList() {
        let count = self.tableView(self.tableView, numberOfRowsInSection: list.count)
        list.removeAll()
        
        self.tableView.deleteRows(at: (0..<count).map({ (i) in IndexPath(row: i, section: 0) }), with: .fade)
    }
    
    @objc func shareSheet() {
        let ac = UIActivityViewController(activityItems: list, applicationActivities: nil)
        
        present(ac, animated: true)
    }
    
}

