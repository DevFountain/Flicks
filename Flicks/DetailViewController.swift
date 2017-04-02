//
//  DetailViewController.swift
//  Flicks
//
//  Created by Curtis Wilcox on 4/1/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!

    var movie: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let movieTitle = movie?["title"] as? String
        movieTitleLabel.text = movieTitle

        let movieOverview = movie?["overview"] as? String
        movieOverviewLabel.text = movieOverview

        if let posterPath = movie?["poster_path"] as? String {
            let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")!
            movieImageView.af_setImage(withURL: posterUrl, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false)
        } else {
            movieImageView.image = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

