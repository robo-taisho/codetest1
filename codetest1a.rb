#problem1 について自力で作成したコード
#題の条件　worst-case time complexity を満たすことが出来ていない。

def solution(array_A, int_N, array_B, int_M)

#array_Aとarray_Bの中の数字が共に存在する範囲をminとmaxから求め、
#解(ans_Sol)が存在しうる最大値を限定する。
#その後、array_Aとarray_Bを検査し、その時点のans_Solよりも小さい
#解の候補を見つけた時点で、ans_Solを乗り換えていく。

  max_A = array_A.max
  min_A = array_A.min
  max_B = array_B.max
  min_B = array_B.min 
  min_Sol = [min_A, min_B].max
  max_Sol = [max_A, max_B].min
  ans_Sol = max_Sol + 1

#array_Aとarray_Bの範囲が被っていない(Aの最大値＜Bの最小値)
#場合には、解が存在しないのでans_Solを-1とする。

if max_A < min_B || max_B < min_A
  ans_Sol = -1
end

#array_Aをfor文で検査する。
#現在の解の候補となる範囲(min_Solからans_Sol)の中にarray_A[i]の値があるときだけ、
#array_Bの検査に入るようにする。

for i in (0..int_N - 1)
  if array_A[i] >= min_Sol && array_A[i] < ans_Sol
    j = 0
    while j < int_M do
      #array_A[i]=array_B[j]かつans_Solよりも小さければ解候補を乗り換える
      if array_A[i] == array_B[j] && array_A[i] < ans_Sol
          ans_Sol = array_A[i]
      end
      #array_B[j]が解になりうる範囲外であれば配列から削除する
      if array_B[j] >= ans_Sol || array_B[j] < min_Sol
        array_B.delete_at(j)
        j = j - 1
        int_M = int_M -1
      end
      j = j + 1
    end
  end
end
  
  #この時点でans_Sol>max_Solであれば、一致した数はなかったということなので
  #-1を返すようにする。 
if ans_Sol > max_Sol
  ans_Sol = -1
end

return ans_Sol
end


=begin
以下はテスト用
現状のアルゴリズムでは、
array_Aが[2, 4, 6, 8 ...]
array_Bが[1, 3, 5, 7 ...]
と互い違いに大きくなっていくような配列が与えられた時に、
worst-case complexity がO(N*M)
にしかなっていない。

array_intA = [10, 99, 6, 7, 9, 2, 3, 5, 6, 7, 9, 2, 3, 5, 6, 7, 9, 2, 3, 5, 6, 7, 9, 1]
int_aN = array_intA.length

array_intB = [1, 4, 8, 5, 4, 8, 1, 4, 8, 1, 4, 8, 10, 3, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 7]
int_bM = array_intB.length

array_intAA = Array(3..100000).map{|i| i*2}
int_aaN = array_intAA.length
array_intBB =  Array(3..100000).map{|i| i*2 + 1}
int_bbM = array_intBB.length

ans = solution(array_intAA, int_aaN, array_intBB, int_bbM)
puts ans
=end
