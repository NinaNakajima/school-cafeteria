require_relative "method"

iFileName = "lunch_gakusyoku.txt"

list = []    # メニューリスト

# ファイル
File.open(iFileName,"r") do |iFile|
  iFile.gets                # ヘッダー1行読み飛ばし
  iFile.each_line do |ll|   # 各行を読み込む
    menu,genre,ingredients,amount,building,money = ll.chomp.split(",")
    list.push({"menu"=>menu,"genre"=>genre,"ingredients"=>ingredients,"amount"=>amount,"building"=>building,"money"=>money})
  end
end


# answerが1になるまで繰り返す
answer = 0
listd = []
5.times do |x|
    print "食べたいジャンルは? 和食 => 1, 洋食 => 2, 中華 => 3, イタリアン => 4, パン => 5, スイーツ => 6, やめる => 0 : \e[36m"
    u_genre = gets.to_i
    if u_genre == 0
      puts
      puts "\e[0mまたのご利用をお待ちしています"
      puts
      puts "END"
      answer = 1
      break
    end
    print "\e[0m飲み物はいかがですか？ y / n : \e[36m"
    u_drink = gets.chomp
    if u_drink == "y"
      list.each do |x|
        if x["building"] == "E"
          listd.push(x)
        end
      end
      list = listd
      drink = choice(list, 7, 0, 1000, 0)
    else
      drink = []
    end
    print "\e[0m今の満腹度は？(0～10) : \e[36m"
    u_amount = gets.to_i
    print "\e[0m何円以内がいいですか？ : \e[36m￥"
    u_money = gets.to_i
    moderateList = choice(list, u_genre, 8 - u_amount, u_money, 0)  # 腹8分目の料理
    lightList = choice(list, u_genre, 6 - u_amount, u_money, 0)  # 軽く食べられる料理
    fullList = choice(list, u_genre, 10 - u_amount, u_money, 0)  # 満腹まで食べられる料理
    otherList = choice(list, u_genre, 8 - u_amount, u_money, 1)  #別のジャンルの料理
    answer = output(moderateList, lightList, fullList, otherList, drink)  # おすすめできるものがなければ0が返ってくる
    break if answer == 1
end
puts "もうええて^^" if answer < 1