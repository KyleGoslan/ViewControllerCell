//
//  ViewController.swift
//  ViewControllerCell
//
//  Created by Kyle Goslan on 2/27/19.
//  Copyright © 2019 Kyle Goslan. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  var numbers = [1,2,3,4,5,6,7]
  var viewControllers = [SubCollectionViewController]()

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(ContainerCell.self, forCellWithReuseIdentifier: "Cell")
    
    for _ in numbers {
      let vc = SubCollectionViewController()
      viewControllers.append(vc)
      addChildContentViewController(vc)
    }
    
    collectionView.reloadData()
    
    view.addSubview(collectionView)
    addConstraints()
  }
  
  private func addChildContentViewController(_ childViewController: UIViewController) {
    addChild(childViewController)
    childViewController.didMove(toParent: self)
  }

  func addConstraints() {
    collectionView.snp.makeConstraints { make in
      make.size.equalToSuperview()
      make.center.equalToSuperview()
    }
  }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ContainerCell
    let vc = viewControllers[indexPath.row]
    cell.hostedView = vc.view
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 180)
  }
  
}


