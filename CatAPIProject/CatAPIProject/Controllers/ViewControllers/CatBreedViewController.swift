//
//  CatBreedViewController.swift
//  CatAPIProject
//
//  Created by James Lea on 5/5/21.
//

import UIKit

class CatBreedViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    // MARK: - Outlets
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var catBreedPicker: UIPickerView!
    @IBOutlet weak var addCatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catTableView.delegate = self
        catTableView.dataSource = self
        
        populatePicker()
        catBreedPicker.delegate = self
        catBreedPicker.dataSource = self
        
        let gradientLayer = CAGradientLayer()
        
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.black.cgColor]
        
        gradientLayer.shouldRasterize = true
        
        gradientLayer.anchorPointZ = 120
        
        view.layer.addSublayer(gradientLayer)
        
//        self.catTableView.backgroundColor = .clear
        self.addCatButton.backgroundColor = .systemBlue
        self.addCatButton.layer.cornerRadius = 10
        
        self.catBreedPicker.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05))
        
    }
    
    // MARK: - Properties
    
    var cats: [Cat] = []
    var pickerData: [String] = []
    var pickerSelected: String = ""
    
    // MARK: - Actions
    
    @IBAction func compareButtonTapped(_ sender: Any) {
        
        
        
        if cats.count == 2 {
            return
        } else {
            
            let alertController = UIAlertController(title: "Need Two Cats", message: "Add two different cats to compare", preferredStyle: .alert)
            
            let doneAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(doneAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
            
        }
        
    }
    
    @IBAction func addCatButtonTapped(_ sender: Any) {
        
        
        
        if cats.first?.name.lowercased() == pickerSelected {
            
            let alertController = UIAlertController(title: "Unable to add cat", message: "You already have added that cat!", preferredStyle: .alert)
            
            let doneAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(doneAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
            
        } else {
        if cats.count < 2 {
            CatBreedController.fetchCatBreed(name: pickerSelected) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let catBreed):
                        guard let cat = catBreed.first else {return}
                        self.cats.append(cat)
                        self.catTableView.reloadData()
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        } else {
            
            let alertController = UIAlertController(title: "Unable to add cat", message: "You already have two cats to compare!", preferredStyle: .alert)
            
            let doneAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(doneAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
            
            }
        }
    }
    
    // MARK: - Picker Requirements
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < pickerData.count else {
            return
        }
        
        let selectedRow = pickerData[row].lowercased()
        
        pickerSelected = selectedRow
    }
    
    // MARK: - Functions
    
    func populatePicker(){
        CatBreedController.fetchCatBreeds { (result) in
            DispatchQueue.main.sync {
                switch result {
                case .success(let cats):
                    var catList: [CatBreed] = []
                    catList = cats

                    for i in catList {
                        self.pickerData.append(i.name)
                        self.catBreedPicker.reloadAllComponents()
                    }

                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCatDetailVC" {
            
            guard let destinationVC = segue.destination as? CatCompareDetailViewController else {return}
            
            let cat1 = cats.first
            let cat2 = cats.last
            destinationVC.cat1 = cat1
            destinationVC.cat2 = cat2
        }
        
        
    }

}

extension CatBreedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
//            self.cats.remove(at: [indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as? CatCellTableViewCell
        
        let catBreed = cats[indexPath.row]
        
        print("hit")
        
        cell?.cat = catBreed
        
        return cell ?? UITableViewCell()
    }
}

//extension CatBreedViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }
//}
