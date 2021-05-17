//
//  UICollectionViewListViewController.swift
//  UiKitSample
//
//  Created by Ryo Narisawa on 2021/05/14.
//

import Foundation
import UIKit

final class UICollectionViewListViewController : UIViewController {
    
    private var titleAndAuthors = [
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
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HH:mm:ss", options: 0, locale: Locale(identifier: "ja_JP"))
        return dateFormatter
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var datasource :  UICollectionViewDiffableDataSource<Section, BookCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // リストのレイアウトの設定
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        // Cellの登録/更新方法を指定
        // ・Xib指定が不要なので実行時エラーを防げる
        let reg = UICollectionView.CellRegistration<CollectionListItemViewCell, BookCell> { cell, indexPath, book in
            cell.id = book.id
            cell.title = book.title
            cell.author = book.author
            cell.dateTime = self.dateFormatter.string(from: book.date)
        }
        
        // リスト更新時に返却するCellを設定
        datasource = UICollectionViewDiffableDataSource<Section, BookCell>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: BookCell) -> UICollectionViewCell? in
            // 再利用可能なセルを返す
            return collectionView.dequeueConfiguredReusableCell(using: reg, for: indexPath, item: item)
        }
        
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        
        let book = titleAndAuthors.randomElement()!
        bookCells.insert(BookCell(id: UUID(),title: book.0, author: book.1, date: Date()), at: 0)
        
        print(bookCells)
        updateList()
    }
    
    @IBAction func removeItem(_ sender: UIButton) {
        
        if bookCells.isEmpty { return }
        bookCells.removeFirst()
        
        updateList()
    }
    
    @IBAction func changeSecondItem(_ sender: UIButton) {
        
        if bookCells.count < 2 { return }
        
        let book = titleAndAuthors.randomElement()!
        let item = BookCell(id: bookCells[1].id, title: book.0, author: book.1, date: Date())
        bookCells[1] = item
        
        updateList()
    }
    
    // リスト更新
    private func updateList() {
        // UICollectionViewにデータを提供する構造体
        var snapshot = NSDiffableDataSourceSnapshot<Section, BookCell>()
        // セクションを追加
        snapshot.appendSections(Section.allCases)
        // 表示するデータを追加
        snapshot.appendItems(bookCells, toSection: .main)
        // snapshotを適用して、UIの変更を反映
        datasource.apply(snapshot, animatingDifferences: true)
    }
}

#if DEBUG
import SwiftUI

extension UICollectionViewListViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UICollectionViewListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController =  storyboard.instantiateViewController(
                identifier: "collectionViewSample") as? UICollectionViewListViewController else {
            fatalError("Cannot load from storyboard")
        }
        // Configure the view controller here
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UICollectionViewListViewController,
                                context: Context) {
    }
}

struct UICollectionViewListViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UICollectionViewListViewController()
    }
}
#endif

