import UIKit

final class PokemonCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  View lifecycle
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    func constraintSubviews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - Internal api
    func configure(pokemonName: String) {
        titleLabel.text = pokemonName
    }
}
