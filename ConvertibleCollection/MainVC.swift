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
    
    //delete button outlet
    @IBOutlet weak var deleteButton: UIButton!
    
    //enumeration that stores the current view layout
    var currentView = ViewFlowLayout.isInGridView
    
    let listFlowLayout = ListLayout()
    let gridFlowLayout = GridLayout()
    
    var selectedArray = [IndexPath]()
    
    var data: [[String:String]] = [
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        deleteButton.isHidden = true
    }
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        
        sampleGallery.dataSource = self
        sampleGallery.delegate = self
        
        //registery to list cell nib
        let nibList = UINib(nibName: "ListCell", bundle: nil)
        sampleGallery.register(nibList, forCellWithReuseIdentifier: "ListCellID")
        
        //registery to grid cell nib
        let nibGrid = UINib(nibName: "GridCell", bundle: nil)
        sampleGallery.register(nibGrid, forCellWithReuseIdentifier: "GridCellID")
        
        sampleGallery.collectionViewLayout = gridFlowLayout
        
        //Handling tap gesture
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(gesture:)))
        longPress.minimumPressDuration = 0.4
        longPress.numberOfTouchesRequired = 1
        self.sampleGallery.addGestureRecognizer(longPress)
        
    }
    
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        //perform deletion of selected element
            for indexPath in selectedArray.sorted(by: >){
            
            data.remove(at: indexPath.item)
        }
        sampleGallery.reloadData()
        selectedArray = [IndexPath]()
        deleteButton.isHidden = true
        buttonToChangeView.isHidden = false
    }
    
    
    
    // action to performed when the button is clicked
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        sampleGallery.reloadData()

        if currentView == .isInGridView {
            viewType.text = "List"
            currentView = .isInListView

            UIView.animate(withDuration: 0.2) { () -> Void in
                self.sampleGallery.collectionViewLayout.invalidateLayout()
                self.sampleGallery.setCollectionViewLayout(self.listFlowLayout, animated: true)}
        }
        else{
            viewType.text = "Grid"
            currentView = .isInGridView

            UIView.animate(withDuration: 0.2) { () -> Void in
                self.sampleGallery.collectionViewLayout.invalidateLayout()
                self.sampleGallery.setCollectionViewLayout(self.gridFlowLayout, animated: true)}
        }
        buttonToChangeView.isSelected = !buttonToChangeView.isSelected
       
        
        //reload datasource to toggle between views.
        
    }
    
    //function to handle long press
    //MARK: longPressAction
    func longPressAction(gesture: UILongPressGestureRecognizer){
        
        buttonToChangeView.isHidden = true
        deleteButton.isHidden = false
        
        gesture.minimumPressDuration = 0.08
        
        if gesture.state == .ended{
            return
        }
        let pressPoint = gesture.location(in: self.sampleGallery)
        if let indexPath = self.sampleGallery.indexPathForItem(at: pressPoint){
            
            let cell = self.sampleGallery.cellForItem(at: indexPath)
            cell?.isSelected = true
            
            if selectedArray.contains(indexPath){
                
                selectedArray.remove(at: selectedArray.index(of: indexPath)!)
                cell?.isSelected = false
                cell?.backgroundColor = nil

//                if selectedArray.isEmpty == true{
//                    
//              }
            }
            else{
                
                cell?.backgroundColor = UIColor.blue
                selectedArray.append(indexPath)
            }
            
            print(selectedArray)
        }
        
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
      
        if currentView == .isInGridView{
    
            guard let cell = sampleGallery.dequeueReusableCell(withReuseIdentifier: "GridCellID", for: indexPath) as? GridCell else{fatalError("Error! No Cell found")}
            
            //update data in cell
            cell.sampleImage.image = UIImage(named: data[indexPath.item]["Image"]!)
            cell.sampleLabelText.text = data[indexPath.item]["Name"]
            cell.backgroundColor = nil
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
    
}
