//
//  TableViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var photosArray: [Photo] = []
  @IBOutlet weak var imagesTableView: UITableView!
  var identifier = "imageCell"
  
  
  override func viewDidLoad() {
    
    photosArray = PhotoProvider().photos()
    
    imagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    
    imagesTableView.delegate = self
    imagesTableView.dataSource = self
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photosArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    
    cell.imageView?.image = photosArray[indexPath.row].image
    cell.textLabel?.text = photosArray[indexPath.row].name
    cell.accessoryType = .detailButton
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Row selected")
  }
  
  func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    print("Accessory selected")
  }
  
}
