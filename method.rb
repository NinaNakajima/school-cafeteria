# method.rb

def choice(list, u_genre, u_amount, u_money, kind)
    # Description: ユーザの食べたいジャンルの料理を配列menuに入れて食べられる料理を配列choiceMenuに追加
    #              それ以外の料理を配列otherに追加してそれぞれの配列を返す
    # list       : メニュー別に配列に入れたもの
    # u_genre    : ユーザの食べたいジャンル(1=>和食, 2=>洋食, 3=>中華, 4=>イタリアン, 5=>韓国料理)
    # u_amount   : ユーザの満腹度との差(例:8分目=>8-ユーザの満腹度)
    # u_money    : ユーザが出せる金額
    # kind       : 0なら配列choiceMenuを返す
    #              1なら配列otherを返す
    
    menu = []
    other = []
    list.each do |i| # lsitの各要素について
        if u_genre == 7 and i["genre"] == "飲み物"# drink
            menu.push(i)
        end
        if i["amount"] == "#{u_amount}" and i["money"].to_i <= u_money and u_genre != 7
            if u_genre == 1 and i["genre"] == "和食"  # 和食なら
                menu.push(i)
            elsif u_genre == 2 and i["genre"] == "洋食"  # 洋食なら
                menu.push(i)
            elsif u_genre == 3 and i["genre"] == "中華"  # 中華なら
                menu.push(i)
            elsif u_genre == 4 and i["genre"] == "イタリアン"  # イタリアンなら
                menu.push(i)
            elsif u_genre == 5 and i["genre"] == "パン"  # パンなら
                menu.push(i)
            elsif u_genre == 6 and i["genre"] == "スイーツ"  # スイーツなら
                menu.push(i)
            else
                other.push(i)
            end
        end
    end
    if kind < 1
        choiceMenu = []
        menu.sort_by! {rand}   # 配列をランダムに並び替える
        num = 0
        menu.each do |x|
            num += 1
            if num < 3
                y = check(x)
                if y == "y"      # 食べられるなら配列choiceMenuに追加して返す(食べられなければ次を聞く)
                    choiceMenu.push(x)
                    return choiceMenu  # choiceMenuを返す
                end
            end
        end
        return choiceMenu    # 全部食べられなければ空の配列を返す
    else
        return other
    end
end

def check(x)
    # Description: その料理が食べられるかどうか聞き, yかnを返す
    # x : 料理の入った配列

    print "\e[0m#{x["ingredients"]}は食べられますか？ y / n : \e[36m"
    y = gets.chomp
    return y
end

def stop
    # Description: 料理を提案するときに, "..."と1秒ずつ表示して間を取る
    
    3.times do
        print "."
        sleep(1)
    end
end

def output(moderateList, lightList, fullList, otherList, drink)
    # Description: ユーザの食べたいジャンルから, おすすめの料理を表示する
    #              ユーザが腹8分目まで食べられる他のジャンルの料理の中から, ランダムで1品提案する
    #              もしユーザの食べたいジャンルからおすすめの料理が見つからない場合は, 0を返す
    #              (lunch.rbでanswer < 1のときは何回も最初からループする
    #               見つかればanswer == 1になりプログラムを終了する)
    # moderateList : ユーザの食べたいジャンルの中で腹8分目まで食べられる料理を入れた配列
    # lightList    : ユーザの食べたいジャンルの中で軽く食べられる料理を入れた配列
    # fullList     : ユーザの食べたいジャンルの中で満腹まで食べられる料理を入れた配列
    # otherList    : ユーザの食べたいジャンル以外で腹8分目まで食べられる料理を入れた配列
    # drink        : ユーザの飲みたい飲み物を入れた配列

    # 色の設定
    color = 33   # 30=>black, 31=>red, 32=>green, 33=>yellow, 34=>blue, 35=>purple, 36=>blueSky, 37=>white

    # 出力
    if moderateList == [] and lightList == [] and fullList == [] # おすすめできるものがなければ
        puts  # 2行改行
        puts
        puts "\e[0mおすすめできるものがありません。ジャンルを変えてみてください"
        puts
        return 0
    else
        # 他のジャンルで腹8分目まで食べられる料理をランダムに選ぶ
        if otherList == []
            otherChoice = 0
        else
            n = rand(otherList.size)
            otherChoice = otherList[n]
            y = check(otherChoice)
            if y == "n"
                otherChoice = 0
            end
        end
        
        puts  # 2行改行
        puts

        # 結果を表示
        # moderateList
        if moderateList.any?
            print "\e[0mあなたにおすすめのメニューは"
            stop    # 3秒溜める
            puts "\e[#{color}m#{moderateList[0]["building"]}校舎\e[0mの食堂の\e[#{color}m#{moderateList[0]["menu"]}(￥#{moderateList[0]["money"]})\e[0mです！"
        end
        # lightList
        if lightList.any?
            print "\e[0m小腹を満たしたいなら"
            stop
            puts "\e[#{color}m#{lightList[0]["building"]}校舎\e[0mの食堂の\e[#{color}m#{lightList[0]["menu"]}(￥#{lightList[0]["money"]})\e[0mが最適です！"
        end
        # fullList
        if fullList.any?
            print "\e[0mお腹いっぱい食べたいなら"
            stop
            puts "\e[#{color}m#{fullList[0]["building"]}校舎\e[0mの食堂の\e[#{color}m#{fullList[0]["menu"]}(￥#{fullList[0]["money"]})\e[0mはいかがですか？"
        end

        if drink.any?
            print "\e[0m飲み物は"
            stop
            puts "\e[#{color}m#{drink[0]["building"]}校舎\e[0mの食堂の\e[#{color}m#{drink[0]["menu"]}(￥#{drink[0]["money"]})\e[0mがおすすめですよ！"
        end
        
        # 他のジャンルのおすすめの料理を表示
        if otherChoice == 0
            # 何もしない
        else
            print "#{otherChoice["genre"]}なら"
            stop
            puts "\e[#{color}m#{otherChoice["building"]}校舎\e[0mの食堂の\e[#{color}m#{otherChoice["menu"]}(￥#{otherChoice["money"]})\e[0mがおすすめです！"
        end    
        return 1    # ループ終了
    end
end