//
//  UITableViewViewController.swift
//  UiKitSample
//
//  Created by Ryo Narisawa on 2021/05/13.
//

import Foundation
import UIKit

class UITableViewViewController: UIViewController, UITableViewDelegate {
    private var books = [
        ("吾輩は猫である", "夏目 漱石"),
        ("羅生門", "芥川 竜之介"),
        ("人間失格", "太宰 治"),
        ("銀河鉄道の夜", "宮沢 賢治"),
        ("蟹工船", "小林多 喜二"),
        ("檸檬", "梶井 基次郎"),
        ("怪人二十面相", "江古川 乱歩"),
        ("山月記", "中島 敦")
    ]
    
    private enum Section: CaseIterable {
        case main
    }
    
    private struct BookCell: Hashable {
        let id: UUID
        let title: String
        let author: String
        let date: Date
    }
    
    private var bookCells = [BookCell]()
    
    private lazy var dataSource: UITableViewDiffableDataSource<Section, BookCell> = {
        let dataSource = UITableViewDiffableDataSource<Section, BookCell>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell") as! ListItemViewCell
            cell.titleLabel.text = item.title
            cell.authorLabel.text = item.author
            cell.datetimeLabel.text = self.dateFormatter.string(from: item.date)
            return cell
        }
        
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HH:mm:ss", options: 0, locale: Locale(identifier: "ja_JP"))
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = dataSource
            // 初期化時にXibを登録
            tableView.register(UINib(nibName: "ListItem", bundle: nil), forCellReuseIdentifier: "ListItemCell")
        }
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let book = books.randomElement()!
        bookCells.insert(BookCell(id: UUID(),title: book.0, author: book.1, date: Date()), at: 0)
        
        updateList()
    }
    
    @IBAction func removeFirstItem(_ sender: UIButton) {
        if bookCells.isEmpty { return }
        bookCells.removeFirst()
        
        updateList()
    }
    
    @IBAction func changeSecondItem(_ sender: UIButton) {
        if bookCells.count < 2 { return }
        
        let book = books.randomElement()!
        let item = BookCell(id: bookCells[1].id, title: book.0, author: book.1, date: Date())
        bookCells[1] = item
        
        updateList()
    }
    
    private func updateList() {
        // Snapshotを取得してDatasourceに反映
        var snapshot = NSDiffableDataSourceSnapshot<Section, BookCell>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(bookCells)
        dataSource.apply(snapshot)
    }
}
