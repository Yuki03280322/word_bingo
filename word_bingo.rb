# 入力内容を配列で取得
lines = []
while line = gets
  lines << line.chomp.split(' ')
end

# ビンゴカードのマス✕マス数を数値で取得し変数へ入れてから配列から削除
bingo_size = lines[0][0].to_i
lines.delete_at(0)

# ビンゴカードに設定した単語のみを抽出し、配列の中に格納
i = 0
num = bingo_size
card_word = []
while num > 0
  card_word << lines[i]
  num -= 1
  i += 1
end
card_words = card_word.flatten

# ビンゴに挑戦する単語の個数を変数へ
word_number = lines[bingo_size][0].to_i

# ビンゴに挑戦する単語を配列の中に1ずつ格納
challenge_word = []
i = 1
word_number.times do
  challenge_word << lines[bingo_size + i]
  i += 1
end
challenge_words = challenge_word.flatten

# 単語の当選判定(ビンゴに挑戦する単語１つ１つに当選判定:true or nil)
word_judge = Array.new(bingo_size * bingo_size)
challenge_words.each do |judge|
  if correct = card_words.find_index(judge)
    word_judge[correct] = true
  end
end

# ビンゴカードの列ごとに配列で区切る
card_judge = word_judge.each_slice(bingo_size).to_a

# ビンゴ判定
yoko = card_judge.any?(&:all?)
tate = card_judge.transpose.any?(&:all?)
naname_one = Array.new(bingo_size){|i| card_judge[i][i]}.all?
naname_two = Array.new(bingo_size){|i| card_judge[i][bingo_size-i-1]}.all?

# ビンゴ結果出力
if yoko || tate || naname_one || naname_two
  puts "yes"
else
  puts "no"
end