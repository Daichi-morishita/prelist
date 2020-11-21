//
//  ViewController.swift
//  prelist
//
//  Created by 森下大地 on 2020/10/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seach: UISearchBar!
    
    // Realmインスタンスを取得する
       let realm = try! Realm()
    
   
    var names = [
    "アメリカ" ,
    "日本",
    "イギリス",
  ]
    //searchbar試し
    //検索結果配列
    var searchResult = [String]()
    //ここまで
    
    // DB内のタスクが格納されるリスト。
       // 日付の近い順でソート：昇順
       // 以降内容をアップデートするとリスト内は自動的に更新される。
       var countryArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //searchbar試し
        //searchBar関連のコード
        
        seach.delegate = self
         
        //何も入力されていなくてもreturnキーを押せる
        seach.enablesReturnKeyAutomatically = false
        
        //検索結果配列にデータをコピーする
        searchResult = names
            //ここまで
    }
    // データの数（＝セルの数）を返すメソッド
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
       }

       // 各セルの内容を返すメソッド
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // 再利用可能な cell を得る
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        //searchbar 試し
        cell.textLabel?.text = names[indexPath.row]
     //ここまで
        
           return cell
       }
    //データの個数を返すメソッド
       func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
           return searchResult.count
       }

       // 各セルを選択した時に実行されるメソッド
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue",sender: nil) // ←追加する
        
       }

    /*
       // セルが削除が可能なことを伝えるメソッド
       func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
           return .delete
       }

       // Delete ボタンが押された時に呼ばれるメソッド
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       }

 */
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
       }
       //  検索バーに入力があったら呼ばれる
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           guard !searchText.isEmpty else {
               searchResult = names
               tableView.reloadData()
               return
           }
           searchResult = names.filter({ item -> Bool in
               item.lowercased().contains(searchText.lowercased())
           })
           tableView.reloadData()
       }
}
