import UIKit

class ViewController: UITableViewController {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var cellSpacingHeigh: CGFloat = 15
    var numberOfRows = 1
    var identifier = "Flag"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        countries = countries.sorted()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { countries.count }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { numberOfRows }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { cellSpacingHeigh }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = countries[indexPath.section]
        cell.imageView?.image = UIImage(named: countries[indexPath.section])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.section]
            vc.imageTitle = countries[indexPath.section]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

