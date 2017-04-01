//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Curtis Wilcox on 4/1/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var movies: [NSDictionary]?

    var apiEndpoint: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        networkRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

        let movie = movies?[indexPath.row]

        let movieTitle = movie?["title"] as? String
        cell.movieTitleLabel.text = movieTitle

        let movieOverview = movie?["overview"] as? String
        cell.movieOverviewLabel.text = movieOverview
        cell.movieOverviewLabel.sizeToFit()

        if let posterPath = movie?["poster_path"] as? String {
            let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")!
            cell.movieImageView.af_setImage(withURL: posterUrl)//, placeholderImage: placeholderImage)
        } else {
            cell.movieImageView.image = nil
        }

        return cell
    }

    func networkRequest() {
        self.apiEndpoint = "now_playing"
        Alamofire.request("https://api.themoviedb.org/3/movie/\(apiEndpoint!)?api_key=\(kTMDbAPIKey)").validate().responseJSON { (response) in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? NSDictionary {
                    print("JSON: \(json)")
                    self.movies = json["results"] as? [NSDictionary]
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

