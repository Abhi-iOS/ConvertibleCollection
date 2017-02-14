//
//  MainVC.swift
//  ConvertibleCollection
//
//  Created by Appinventiv on 13/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
//MARK: Class MainVC
class MainVC: UIViewController {
    //Outlet of collection view
    @IBOutlet weak var sampleGallery: UICollectionView!
    
    //Outlet of button that toggles between grid and list view
    @IBOutlet weak var buttonToChangeView: UIButton!
    
    //Outlet that shows the current view Type
    @IBOutlet weak var viewType: UILabel!
    var isInGridView = true
    
    
    
    let data: [[String:String]] = [
    
        ["Name": "Iron man", "Image": "IM"],
        ["Name": "Green Arrow", "Image": "Arrow"],
        ["Name": "Flash", "Image": "flash"],
        ["Name": "Reverse Flash", "Image": "revFlash"],
        ["Name": "Zoom", "Image": "Zoom"],
        ["Name": "Black Hawk", "Image": "bx"],
        ["Name": "Green Lantern", "Image": "GL"],
        ["Name": "Captain America", "Image": "CA"],
        ["Name": "Tin Man", "Image": "tin"]
    ]
    
    
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        sampleGallery.dataSource = self
        sampleGallery.delegate = self
        
        //registery to list cell nib
        let nibList = UINib(nibName: "ListCell", bundle: nil)
        sampleGallery.register(nibList, forCellWithReuseIdentifier: "ListCellID")
        
        //registery to grid cell nib
        let nibGrid = UINib(nibName: "GridCell", bundle: nil)
        sampleGallery.register(nibGrid, forCellWithReuseIdentifier: "GridCellID")
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    // action to performed when the button is clicked
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        if isInGridView{
            viewType.text = "List"
        }
        
        else{
            viewType.text = "Grid"
        }
        buttonToChangeView.isSelected = !buttonToChangeView.isSelected
        isInGridView = !isInGridView
        
//        UICollectionView.transition(with: sampleGallery, duration: 1, options: UIViewAnimationOptions.tra, animations: {self.sampleGallery.reloadData()}, completion: nil)
        
        //reload datasource to toggle between views.
        sampleGallery.reloadData()

    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
extension MainVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    //returns number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    //returns item cell at particular index
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        if isInGridView{
    
            guard let cell = sampleGallery.dequeueReusableCell(withReuseIdentifier: "GridCellID", for: indexPath) as? GridCell else{fatalError("Error! No Cell found")}
            
            //update data in cell
            cell.sampleImage.image = UIImage(named: data[indexPath.item]["Image"]!)
            cell.sampleLabelText.text = data[indexPath.item]["Name"]
            cell.layoutIfNeeded()

            return cell
            
        }
        else{

            guard let cell = sampleGallery.dequeueReusableCell(withReuseIdentifier: "ListCellID", for: indexPath) as? ListCell else{fatalError("Error! No Cell found")}
            
            //update data in cell
            cell.sampleImage.image = UIImage(named: data[indexPath.item]["Image"]!)
            cell.sampleLabelText.text = data[indexPath.item]["Name"]
            cell.layoutIfNeeded()
            
            return cell
        }
    }
    
    //return size of item cell height of width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if isInGridView{
            return CGSize(width: 270, height: 200)
        }
        else{
            return CGSize(width: sampleGallery.frame.width, height: 65)
        }
    }
    
}
