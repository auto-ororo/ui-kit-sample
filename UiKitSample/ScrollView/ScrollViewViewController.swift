//
//  ScrollViewViewController.swift
//  UiKitSample
//
//  Created by ororo on 2021/05/15.
//

import Foundation
import UIKit

final class ScrollViewViewController: UIViewController {
    
    private let storyString = """
    　吾輩わがはいは猫である。名前はまだ無い。
    　どこで生れたかとんと見当けんとうがつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。しかもあとで聞くとそれは書生という人間中で一番獰悪どうあくな種族であったそうだ。この書生というのは時々我々を捕つかまえて煮にて食うという話である。しかしその当時は何という考もなかったから別段恐しいとも思わなかった。ただ彼の掌てのひらに載せられてスーと持ち上げられた時何だかフワフワした感じがあったばかりである。掌の上で少し落ちついて書生の顔を見たのがいわゆる人間というものの見始みはじめであろう。この時妙なものだと思った感じが今でも残っている。第一毛をもって装飾されべきはずの顔がつるつるしてまるで薬缶やかんだ。その後ご猫にもだいぶ逢あったがこんな片輪かたわには一度も出会でくわした事がない。のみならず顔の真中があまりに突起している。そうしてその穴の中から時々ぷうぷうと煙けむりを吹く。どうも咽むせぽくて実に弱った。これが人間の飲む煙草たばこというものである事はようやくこの頃知った。
    　この書生の掌の裏うちでしばらくはよい心持に坐っておったが、しばらくすると非常な速力で運転し始めた。書生が動くのか自分だけが動くのか分らないが無暗むやみに眼が廻る。胸が悪くなる。到底とうてい助からないと思っていると、どさりと音がして眼から火が出た。それまでは記憶しているがあとは何の事やらいくら考え出そうとしても分らない。
    　ふと気が付いて見ると書生はいない。たくさんおった兄弟が一疋ぴきも見えぬ。肝心かんじんの母親さえ姿を隠してしまった。その上今いままでの所とは違って無暗むやみに明るい。眼を明いていられぬくらいだ。はてな何でも容子ようすがおかしいと、のそのそ這はい出して見ると非常に痛い。吾輩は藁わらの上から急に笹原の中へ棄てられたのである。
    　ようやくの思いで笹原を這い出すと向うに大きな池がある。吾輩は池の前に坐ってどうしたらよかろうと考えて見た。別にこれという分別ふんべつも出ない。しばらくして泣いたら書生がまた迎に来てくれるかと考え付いた。ニャー、ニャーと試みにやって見たが誰も来ない。そのうち池の上をさらさらと風が渡って日が暮れかかる。腹が非常に減って来た。泣きたくても声が出ない。仕方がない、何でもよいから食物くいもののある所まであるこうと決心をしてそろりそろりと池を左ひだりに廻り始めた。どうも非常に苦しい。そこを我慢して無理やりに這はって行くとようやくの事で何となく人間臭い所へ出た。ここへ這入はいったら、どうにかなると思って竹垣の崩くずれた穴から、とある邸内にもぐり込んだ。縁は不思議なもので、もしこの竹垣が破れていなかったなら、吾輩はついに路傍ろぼうに餓死がししたかも知れんのである。一樹の蔭とはよく云いったものだ。この垣根の穴は今日こんにちに至るまで吾輩が隣家となりの三毛を訪問する時の通路になっている。さて邸やしきへは忍び込んだもののこれから先どうして善いいか分らない。そのうちに暗くなる、腹は減る、寒さは寒し、雨が降って来るという始末でもう一刻の猶予ゆうよが出来なくなった。仕方がないからとにかく明るくて暖かそうな方へ方へとあるいて行く。今から考えるとその時はすでに家の内に這入っておったのだ。ここで吾輩は彼かの書生以外の人間を再び見るべき機会に遭遇そうぐうしたのである。第一に逢ったのがおさんである。これは前の書生より一層乱暴な方で吾輩を見るや否やいきなり頸筋くびすじをつかんで表へ抛ほうり出した。いやこれは駄目だと思ったから眼をねぶって運を天に任せていた。しかしひもじいのと寒いのにはどうしても我慢が出来ん。吾輩は再びおさんの隙すきを見て台所へ這はい上あがった。すると間もなくまた投げ出された。吾輩は投げ出されては這い上り、這い上っては投げ出され、何でも同じ事を四五遍繰り返したのを記憶している。その時におさんと云う者はつくづくいやになった。この間おさんの三馬さんまを偸ぬすんでこの返報をしてやってから、やっと胸の痞つかえが下りた。吾輩が最後につまみ出されようとしたときに、この家うちの主人が騒々しい何だといいながら出て来た。下女は吾輩をぶら下げて主人の方へ向けてこの宿やどなしの小猫がいくら出しても出しても御台所おだいどころへ上あがって来て困りますという。主人は鼻の下の黒い毛を撚ひねりながら吾輩の顔をしばらく眺ながめておったが、やがてそんなら内へ置いてやれといったまま奥へ這入はいってしまった。主人はあまり口を聞かぬ人と見えた。下女は口惜くやしそうに吾輩を台所へ抛ほうり出した。かくして吾輩はついにこの家うちを自分の住家すみかと極きめる事にしたのである。
    """

    @IBOutlet weak var story: UILabel!
    
    @IBAction func toggleStory(_ sender: UIButton) {
        if story.text?.isEmpty == true {
            story.text = storyString
        } else {
            story.text = ""
        }
    }
    
    @IBAction func showLink(_ sender: UIButton) {
        let url = URL(string: "https://www.aozora.gr.jp/")
        UIApplication.shared.open(url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

#if DEBUG
import SwiftUI

extension ScrollViewViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ScrollViewViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController =  storyboard.instantiateViewController(
                identifier: "scrollViewSample") as? ScrollViewViewController else {
            fatalError("Cannot load from storyboard")
        }
        
        // Configure the view controller here
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ScrollViewViewController,
                                context: Context) {
    }
}

struct ScrollViewViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ScrollViewViewController()
    }
}
#endif

