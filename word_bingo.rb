class Bingo

  #標準入力の受け取り
  def initialize
    @s = gets.to_i#s × sの行列
    #ビンゴカードを配列に入れる。ビンゴカードを行列に見立て、2次元配列で表現。
    @s.times{ @words << gets.chomp.split }
    @words = []
    @w = gets.to_i#選ばれた単語の数
    #選ばれた単語を配列に入れる
    @call = []
    @w.times{ @call << gets.chomp }
  end

  #選ばれた単語(called)と一致する単語をwords配列から見つけ、nilとする
  def find_word
    @call.each do |called|#@call配列から単語を取り出し@words配列を走査する
      @words.each.with_index do |row, i|#i行目の
        row.each.with_index do |word, j|#j番目の単語をnilにする
          @words[i][j] = nil if word == called
        end
      end
    end
  end

  #横のビンゴ判定
  #行が全てnilならば横のビンゴとなるため、
  #配列の一つの要素(row)が全てnilならばビンゴとする
  def judge_row
    find_word#nil入りビンゴカード(@words)の取得
    judge = false#ビンゴ判定
    @words.each{|row| judge = true if row.all?(nil)}
    return judge
  end
 
  #縦のビンゴ判定
  #ビンゴカードを転置し、全ての要素がnilならば縦のビンゴとなる
  #転置した後、横のビンゴと同様にビンゴ判定する
  def judge_column
    find_word
    judge = false
    trans = @words.transpose
    trans.each{|column| judge = true if column.all?(nil)}
    return judge
  end

  #斜めのビンゴ判定
  #斜めの単語をnaname配列に入れて、すべての要素がnilならビンゴ判定をする
  def judge_diagram
    find_word
    judge = false
    #右下斜め:naname1, 左下斜め:naname2
    naname1 = []
    naname2 = []
    #右下斜めの要素をnaname1に入れる
    #右下斜めの単語は[0][0],[1][1],[2][2],..,[@s - 1][@s - 1]という規則性があるので、それに則り配列に入れる
    for i in 0..(@s - 1) do
      naname1 << @words[i][i]
    end
    #左下斜めの要素をnaname2に入れる
    #左下斜めの単語は[0][@s - 1],[1][@s - 2],[2][@s - 3],..,[@s - 1][0]という規則性があるので、それに則り配列に入れる
    (@s -1).downto(0).each do |i|
      naname2 << @words[@s-1-i][i]
    end
    #右下斜めの配列と左下斜めの配列に対し、それぞれ全ての要素がnilであればビンゴとする
    if naname1.all?(nil) || naname2.all?(nil)
      judge = true
    end
    return judge
  end

  def final_judge
    #横・縦・斜め、いずれかでビンゴならyesを出力、それ以外はnoを出力する
    puts judge_row || judge_column || judge_diagram == true ? "yes" : "no"
  end
end

Bingo.new.final_judge