//
//  CatCompareDetailViewController.swift
//  CatAPIProject
//
//  Created by James Lea on 5/6/21.
//

import UIKit

class CatCompareDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cat1Image: UIImageView!
    @IBOutlet weak var cat2Image: UIImageView!
    @IBOutlet weak var cat1Name: UILabel!
    @IBOutlet weak var cat2Name: UILabel!
    @IBOutlet weak var cat1Desc: UILabel!
    @IBOutlet weak var cat2Desc: UILabel!
    @IBOutlet weak var cat1Adapt: UILabel!
    @IBOutlet weak var cat2Adapt: UILabel!
    @IBOutlet weak var cat1Affection: UILabel!
    @IBOutlet weak var cat2Affection: UILabel!
    @IBOutlet weak var cat1ChildFriendly: UILabel!
    @IBOutlet weak var cat2ChildFriendly: UILabel!
    @IBOutlet weak var cat1DogFriendly: UILabel!
    @IBOutlet weak var cat2DogFriendly: UILabel!
    @IBOutlet weak var cat1EnergyLevel: UILabel!
    @IBOutlet weak var cat2EnergyLevel: UILabel!
    @IBOutlet weak var cat1Grooming: UILabel!
    @IBOutlet weak var cat2Grooming: UILabel!
    @IBOutlet weak var cat1HealthIssues: UILabel!
    @IBOutlet weak var cat2HealthIssues: UILabel!
    @IBOutlet weak var cat1Intelligence: UILabel!
    @IBOutlet weak var cat2Intelligence: UILabel!
    @IBOutlet weak var cat1SheddingLevel: UILabel!
    @IBOutlet weak var cat2SheddingLevel: UILabel!
    @IBOutlet weak var cat1SocialLevel: UILabel!
    @IBOutlet weak var cat2SocialLevel: UILabel!
    @IBOutlet weak var cat1Vocalisation: UILabel!
    @IBOutlet weak var cat2Vocalisation: UILabel!
    @IBOutlet weak var cat1Hypoallergenic: UILabel!
    @IBOutlet weak var cat2Hypoallergenic: UILabel!
    @IBOutlet weak var catDescriptionBannerLabel: UILabel!
    @IBOutlet weak var catNameBannerLabel: UILabel!
    @IBOutlet weak var catRatingsBannerLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCatPics()
        updateViews()
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.black.cgColor]
        
        gradientLayer.shouldRasterize = true
        
        gradientLayer.anchorPointZ = 1
        
        view.layer.addSublayer(gradientLayer)
        
        self.catDescriptionBannerLabel.backgroundColor = UIColor(cgColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.1))
        self.catNameBannerLabel.backgroundColor = UIColor(cgColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.1))
        self.catRatingsBannerLabel.backgroundColor = UIColor(cgColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.1))
        
    }
    var cat1: Cat?
    var cat2: Cat?
    
    // MARK: - Functions
    func updateViews(){
        guard let cat1 = cat1,
              let cat2 = cat2 else {return}
        self.cat1Name.text = cat1.name
        self.cat2Name.text = cat2.name
        self.cat1Desc.text = cat1.description
        self.cat2Desc.text = cat2.description
        self.cat1Adapt.text = "\(cat1.adaptability)/5"
        self.cat2Adapt.text = "\(cat2.adaptability)/5"
        self.cat1Affection.text = "\(cat1.affection_level)/5"
        self.cat2Affection.text = "\(cat2.affection_level)/5"
        self.cat1ChildFriendly.text = "\(cat1.child_friendly)/5"
        self.cat2ChildFriendly.text = "\(cat2.child_friendly)/5"
        self.cat1DogFriendly.text = "\(cat1.dog_friendly)/5"
        self.cat2DogFriendly.text = "\(cat2.dog_friendly)/5"
        self.cat1EnergyLevel.text = "\(cat1.energy_level)/5"
        self.cat2EnergyLevel.text = "\(cat2.energy_level)/5"
        self.cat1Grooming.text = "\(cat1.grooming)/5"
        self.cat2Grooming.text = "\(cat2.grooming)/5"
        self.cat1HealthIssues.text = "\(cat1.health_issues)/5"
        self.cat2HealthIssues.text = "\(cat2.health_issues)/5"
        self.cat1Intelligence.text = "\(cat1.intelligence)/5"
        self.cat2Intelligence.text = "\(cat2.intelligence)/5"
        self.cat1SheddingLevel.text = "\(cat1.shedding_level)/5"
        self.cat2SheddingLevel.text = "\(cat2.shedding_level)/5"
        self.cat1SocialLevel.text = "\(cat1.social_needs)/5"
        self.cat2SocialLevel.text = "\(cat2.social_needs)/5"
        self.cat1Vocalisation.text = "\(cat1.vocalisation)/5"
        self.cat2Vocalisation.text = "\(cat2.vocalisation)/5"
        self.cat1Hypoallergenic.text = "\(cat1.hypoallergenic)/5"
        self.cat2Hypoallergenic.text = "\(cat2.hypoallergenic)/5"
    }
    
    func fetchCatPics(){
        
        guard let cat1 = cat1,
              let cat2 = cat2 else {return}
        
        CatAPIProject.CatBreedController.fetchCatImageURL(cat: cat1) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    CatBreedController.fetchCatImage(url: image.url) { (result2) in
                        DispatchQueue.main.async {
                            switch result2 {
                            case .success(let finalImage):
                                self.cat1Image.image = finalImage
                            case .failure(let error):
                                self.cat1Image.image = UIImage(named: "CatNotFound")
                                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                            }
                        }
                    }
                    print(image)
                case .failure(let error):
                    self.cat1Image.image = UIImage(named: "CatNotFound")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
        CatAPIProject.CatBreedController.fetchCatImageURL(cat: cat2) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    CatBreedController.fetchCatImage(url: image.url) { (result2) in
                        DispatchQueue.main.async {
                            switch result2 {
                            case .success(let finalImage):
                                self.cat2Image.image = finalImage
                            case .failure(let error):
                                self.cat2Image.image = UIImage(named: "CatNotFound")
                                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                            }
                        }
                    }
                    print(image)
                case .failure(let error):
                    self.cat2Image.image = UIImage(named: "CatNotFound")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
