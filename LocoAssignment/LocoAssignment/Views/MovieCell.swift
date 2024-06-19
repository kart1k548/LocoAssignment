import UIKit

/// Collecton View Cell responsible for handling the UI of every cell inside the collection view
class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    public func configure(with viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.movieTitle
        
        self.imageView.loadImage(with: viewModel.moviePosterUrl)
    }
}
