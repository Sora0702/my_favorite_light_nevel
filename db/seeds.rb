# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do |n|
  User.create(
    name: "user#{n + 1}",
    introduction: "user#{n + 1}です。",
    email: "user#{n + 1}@exapmle.com",
    password: "password"
  )
end

book = Book.create(
  title: "わたし、二番目の彼女でいいから。6",
  image_url: "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/1282/9784049151282_1_3.jpg?_ex=200x200",
  isbn: "9784049151282",
  url: "https://books.rakuten.co.jp/rb/17501188/",
  author: "西　条陽/Re岳"
)

2.times do |n|
  Review.create(
    book_id: 1,
    user_id: n + 1,
    content: "テスト用データ#{n + 1}です"
  )
end

narou = Narou.create(
  ncode: "n8856gp",
  title: "霜月さんはモブが好き",
  story: "普通のラブコメなら、俺はただのモブキャラでしかなかっただろう。
          義理の妹も、女友達も、幼馴染も、みんなモテモテなあいつを好きになった。
          何もせずとも生まれながらに女子に好かれる主人公様は、呆気なく俺が大切に思っていた彼女たちをハーレムメンバーにして、
          青春ラブコメを楽しんでいる。モブキャラの俺は、教室の端っこから主人公様を眺めることしかできないはずだった……でも、彼女はそんな俺を見つけてくれた。
          主人公様の幼馴染であり、メインヒロインという立場にいるにも関わらず、彼女は俺を選んでくれた。
          普段は無口で無表情だけど、彼女は俺にだけはオシャベリになるし、笑顔を見せてくれる。
          主人公様よりも、モブキャラの俺を特別だと言ってくれたのだ――これは、そんな冴えないモブキャラの物語。メタ視点で物語る、
          霜月さんが好きになってくれたモブキャラのラブコメである。",
  writer: "八神鏡@『霜月さんはモブが好き』コミカライズ＆4巻発売中！"
)

2.times do |n|
  NarouReview.create(
    narou_id: 1,
    user_id: n + 1,
    content: "テスト用データ#{n + 1}です"
  )
end
