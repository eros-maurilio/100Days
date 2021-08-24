import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var flagImageView: UIImageView!
    var selectedImage: String?
    var imageTitle: String?
    
    override func viewDidLoad() {
        title = imageTitle
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        super.viewDidLoad()
        if let imageToLoad = selectedImage {
            flagImageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.8) else { return }
        guard let text = imageTitle else { return }
        
    let vc = UIActivityViewController(activityItems: [image, text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }

}
