// *************************************************************************************************
// - MARK: Imports


import UIKit


// *************************************************************************************************
// - MARK: MovieSearchViewController


class MovieSearchViewController: UIViewController {
    
    
    var movies: [Movie]?
    let searchController = UISearchController(searchResultsController: nil)
    let tableView: UITableView! = UITableView(frame: .zero)
    
    
    // - MARK: Overrided Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBarController()
        setupTableView()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    
    // - MARK: Private Methods
    
    
    private func searchMovie(with title: String?) {
        guard let title = title else { return }
        MovieDBService.searchMovie(title: title) { [weak self] response, error in
            DispatchQueue.main.async {
                if error != nil {
                    // TODO: show error message?
                    return
                }
                self?.movies = response?.results
                self?.tableView.reloadData()
            }
        }
    }
    
    
    private func setupSearchBarController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "MovieSummaryCell", bundle: nil),
                              forCellReuseIdentifier: MovieSummaryCell.identifier)
        tableView.register(EmptyListCell.self,
                           forCellReuseIdentifier: EmptyListCell.identifier)
        view.addSubview(tableView)
        view.backgroundColor = UIColor.black
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.estimatedRowHeight = view.bounds.size.height
        wireDelegation()
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.lightGray
    }
    
    
    private func wireDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}


// *************************************************************************************************
// - MARK: UITableViewDelegate


extension MovieSearchViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let movies = movies else {
            return view.bounds.height
        }
        
        return movies.count > 0 ? view.bounds.height / 8 : view.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = movies?[indexPath.row] {
            let vc = MovieDetailsViewController()
            vc.movie = movie
            
            navigationController?.pushViewController(vc, animated: true)
            searchController.isActive = false
        }
    }
}


// *************************************************************************************************
// - MARK: UITableViewDataSource


extension MovieSearchViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let movies = movies else { return 1 }

        return movies.count > 0 ? movies.count : 1

    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCount = movies?.count, movieCount != 0 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyListCell.identifier,
                                                     for: indexPath) as! EmptyListCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieSummaryCell.identifier,
                                                 for: indexPath) as! MovieSummaryCell
        if let movie = movies?[indexPath.row] {
            cell.movie = movie
        }
        
        return cell
    }
    
    
}


// *************************************************************************************************
// MARK: - UISearchResultsUpdating Delegate


extension MovieSearchViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchMovie(with: searchController.searchBar.text)
    }
    
    
}
