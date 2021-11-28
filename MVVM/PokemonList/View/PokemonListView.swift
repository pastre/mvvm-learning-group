import UIKit

final class PokemonListView: UIView {
    // MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(PokemonCell.self, forCellReuseIdentifier: "PokemonCell")
        view.rowHeight = 100
        return view
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        addSubiews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should not be called")
    }
    
    // MARK: - UI Lifecycle
    
    func addSubiews() {
        addSubview(tableView)
    }
    
    func constraintSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: topAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - Internal API
    
    func bind(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
