import UIKit

/// Controller responsible for handling the UI of Movie Detail screen
class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModel?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var directorName: UILabel!
    @IBOutlet weak var moviePlot: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.setupUI()
        viewModel?.onMovieReceived = { [weak self] in
            if let _ = self?.viewModel?.movieDetail {
                self?.updateUI()
            } else {
                print("self is nil")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchMovieDetail()
    }
    
    /// sets up the UI initially by populating UI Elements with their initial value
    private func setupUI() {
        posterImageView.loadImage(with: viewModel?.movie.posterUrl ?? "")
        movieTitle.text = viewModel?.movie.title
        movieReleaseDate.text = ""
        directorName.text = ""
        moviePlot.text = ""
    }
    
    /// updates the values of UI Elements after we receive the response from the API
    private func updateUI() {
        movieReleaseDate.text = viewModel?.movieDetail.releaseDate
        directorName.text = viewModel?.movieDetail.director
        moviePlot.text = viewModel?.movieDetail.plot
    }
}
