//
//  ViewController.swift
//  Project1-100DaysOfSwift
//
//  Created by Eros Maurilio on 06/08/21.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    var total = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        performSelector(inBackground: #selector(getItems), with: nil)
    }
    
    @objc func getItems() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
            }
        }
        pictures = pictures.sorted()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
//        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { pictures.count }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else { fatalError("Unable to dequeue cell") }
        
        let pic = pictures[indexPath.item]

        cell.imageView.image = UIImage(named: pic)
        cell.title.text = pic
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 5

        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            vc.imageTitle = "Photo \(indexPath.item + 1) of \(collectionView.numberOfItems(inSection: 0))"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pictures.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
//        cell.textLabel?.text = pictures[indexPath.row]
//        print("\(pictures[indexPath.item])")
//        return cell
//    }
//
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            vc.selectedImage = pictures[indexPath.row]
//            vc.imageTitle = "Photo \(indexPath.row + 1) of \(tableView.numberOfRows(inSection: 0))"
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    @objc func shareTapped() {
        let text = "Recommend this app to anyone"
        
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

}

