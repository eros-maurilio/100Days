//
//  ViewController.swift
//  Project10
//
//  Created by Eros Maurilio on 12/11/21.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var people = [Person]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { people.count }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        
        let person = people[indexPath.item]
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        
        cell.name.text = person.name
        
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unkwon", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionAlert(people, at: indexPath.item)
    }
    
    func actionAlert(_ people: [Person], at index: Int) {
        let ac = UIAlertController(title: "Chose", message: "What you wanna do?", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deleteItem(index: index)
        }))
        
        ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { _ in
            self.editName(people, at: index)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.editName(people, at: index)
        }))
        
        present(ac, animated: true)
    }
    
    
    func deleteItem(index: Int) {
        let ac = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.people.remove(at: index)
            self.collectionView.reloadData()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
        
    }
    
    func editName(_ person: [Person], at index: Int) {
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            
            person[index].name = newName
            self?.collectionView.reloadData()
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}

