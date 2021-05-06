//
//  CatCellTableViewCell.swift
//  CatAPIProject
//
//  Created by James Lea on 5/5/21.
//

import UIKit

class CatCellTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catCellImage: UIImageView!
    
    // MARK: - Properties
    var cat: Cat? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let cat = cat else {return}
        
        catNameLabel.text = "\(cat.name) Cat"
        
        CatBreedController.fetchCatImageURL(cat: cat, completion:{ (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    CatBreedController.fetchCatImage(url: image.url) { (result2) in
                        DispatchQueue.main.async {
                            switch result2 {
                            case .success(let finalImage):
                                self.catCellImage.image = finalImage
                            case .failure(let error):
                                self.catCellImage.image = UIImage(named: "CatNotFound")
                                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                            }
                        }
                    }
                    print(image)
                case .failure(let error):
                    self.catCellImage.image = UIImage(named: "CatNotFound")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        })
    }
}
