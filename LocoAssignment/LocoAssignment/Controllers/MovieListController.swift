import UIKit

/// Controller responsible for handling and setting up the UI for home screen
class MovieListController: UIViewController {
    
    private let viewModel = MovieListViewModel()
    
    private var movieDetailViewModel: MovieDetailViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView?.collectionViewLayout = UICollectionViewFlowLayout()
        self.navigationItem.title = "Movies List"
        viewModel.onMoviesReceived = { [weak self] in
            self?.searchTextField.resignFirstResponder()
            self?.collectionView?.reloadData()
        }
    }
    
    @IBAction func onSearchTap(_ sender: Any) {
        if let searchKeyword = searchTextField.text {
            viewModel.setDefaultState()
            viewModel.searchKeyword = searchKeyword
            viewModel.fetchMovies()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailViewController {
            destination.viewModel = movieDetailViewModel
        }
    }
}

extension MovieListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configure(with: MovieCellViewModel(movie: viewModel.movies[indexPath.row]))
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = (collectionView.frame.size.width-10)/2
        
        return CGSize(width: dimension, height: dimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = MovieDetailViewModel(movie: viewModel.movies[indexPath.row])
        self.movieDetailViewModel = viewModel
        performSegue(withIdentifier: "MovieDetailSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.haveMorePages && indexPath.row == viewModel.movies.count-1 {
            viewModel.fetchMovies()
        }
    }
}

