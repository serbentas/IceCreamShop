//
//  ViewController.swift
//  IceCreamShop
//
//  Created by Joshua Greene on 2/8/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import UIKit
import Alamofire
import BetterBaseClasses
import MBProgressHUD

public class PickFlavorViewController: BaseViewController, UICollectionViewDelegate {
  
  // MARK: Instance Variables
  
  var flavors: [Flavor] = [] {
    
    didSet {
      pickFlavorDataSource?.flavors = flavors
    }
  }
  
  private var pickFlavorDataSource: PickFlavorDataSource? {
    return collectionView?.dataSource as! PickFlavorDataSource?
  }
  
  private let flavorFactory = FlavorFactory()
  
  // MARK: Outlets
  
  @IBOutlet var contentView: UIView!
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var iceCreamView: IceCreamView!
  @IBOutlet var label: UILabel!
  
  // MARK: View Lifecycle
  
  public override func viewDidLoad() {
    
    super.viewDidLoad()
    loadFlavors()
  }
  
  private func loadFlavors() {
    
    // 1
    
    showLoadingHUD()
    
    Alamofire.request(
      .GET, "http://www.raywenderlich.com/downloads/Flavors.plist",
      parameters: nil,
      encoding: .PropertyList(.XMLFormat_v1_0, 0), headers: nil)
      .responsePropertyList { response in
        
        // 2
        /* guard let strongSelf = self else {
         return
         }*/
        self.hideLoadingHUD()
        
        var flavorsArray: [[String : String]]! = nil
        
        // 3
        switch response.result {
          
        case .Success(let array):
          if let array = array as? [[String : String]] {
            flavorsArray = array
          }
          
        case .Failure( _):
          print("Couldn't download flavors!") 
          return 
        } 
        
        // 4 
        self.flavors = self.flavorFactory.flavorsFromDictionaryArray(flavorsArray) 
        self.collectionView.reloadData() 
        self.selectFirstFlavor() 
    }; 
  }
  
  private func showLoadingHUD() {
    let hud = MBProgressHUD.showHUDAddedTo(contentView, animated: true)
    hud.labelText = "Loading..."
  }
  
  private func hideLoadingHUD() {
    MBProgressHUD.hideAllHUDsForView(contentView, animated: true)
  }
  
  private func selectFirstFlavor() {
    
    if let flavor = flavors.first {
      updateWithFlavor(flavor)
    }
  }
  
  // MARK: UICollectionViewDelegate
  
  public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    let flavor = flavors[indexPath.row]
    updateWithFlavor(flavor)
  }
  
  // MARK: Internal
  
  private func updateWithFlavor(flavor: Flavor) {
    
    iceCreamView.updateWithFlavor(flavor)
    label.text = flavor.name
  }
}