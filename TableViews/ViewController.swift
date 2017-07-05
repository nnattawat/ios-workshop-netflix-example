//
//  ViewController.swift
//  TableViews
//
//  Created by Rhydian Thomas on 13/1/17.
//  Copyright © 2017 NA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  var movies = [Movie]()
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")
    cell?.textLabel?.text = movies[indexPath.row].showTitle
    cell?.detailTextLabel?.text = movies[indexPath.row].releaseYear
    return cell!
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Mel Movies"
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie = movies[indexPath.row]
    
    let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
    let alertController = UIAlertController(title: movie.showTitle, message: movie.summary, preferredStyle: .alert)
    alertController.addAction(closeAction)
    
    self.present(alertController, animated: true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    NetflixClient().fetch(forActorName: "Mel Gibson") { movies in
      self.movies = movies
      self.tableView.reloadData()
    }
  }

}

