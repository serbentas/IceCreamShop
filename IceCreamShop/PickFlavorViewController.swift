//
//  ViewController.swift
//  IceCreamShop
//
//  Created by Joshua Greene on 2/8/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import UIKit

public class PickFlavorViewController: UIViewController, UICollectionViewDelegate {
  
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
    // TO-DO: Implement this
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
