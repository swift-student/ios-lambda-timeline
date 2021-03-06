//
//  SelectFilterViewController.swift
//  ImageFilterEditor
//
//  Created by Shawn Gee on 5/4/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit
import CoreImage.CIFilterBuiltins

class SelectFilterViewController: UIViewController {

    // MARK: - Public Properteis
    
    var animationDuration: TimeInterval?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet private weak var filterCollectionView: UICollectionView!
    @IBOutlet private var showFilterContainerConstraint: NSLayoutConstraint!
    
    // MARK: - Private Properties
    
    let filters = [
        VignetteFilter(),
        VignetteFilter(),
        VignetteFilter(),
        VignetteFilter(),
        VignetteFilter(),
    ]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFilterContainerConstraint.isActive = false
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateContentSize()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let applyFilterVC = segue.destination as? ApplyFilterViewController, let indexPath = filterCollectionView.indexPathsForSelectedItems?.first {
            applyFilterVC.filter = filters[indexPath.item]
        }
    }
    
    // MARK: - Private Methods

    private func updateContentSize() {
        if showFilterContainerConstraint.isActive {
            preferredContentSize.height = toolbar.frame.height + filterCollectionView.frame.height + view.safeAreaInsets.bottom
        } else {
            preferredContentSize.height = toolbar.frame.height + view.safeAreaInsets.bottom
        }
    }

    // MARK: - IBActions
    
    @IBAction func showFilters(_ sender: Any) {
        guard let animationDuration = animationDuration else { return }
        
        showFilterContainerConstraint.isActive.toggle()
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
        updateContentSize()
    }
}

// MARK: UICollectionViewDataSource

extension SelectFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterCell else {
            fatalError("Unable to cast cell as \(FilterCell.self)")
        }
    
        cell.imageView.image = filters[indexPath.row].icon
    
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension SelectFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ApplyFilterSegue", sender: self)
    }
}

   

   

   
   
   
