class Array
  def merge_sort ( first = 0 , last = (size-1) )
  #問題文中の、worst­case time complexity N*log N
  #より、マージソートを使って配列を並び替える。
  #配列A、Bをマージソートで並び変えた後で先頭から順番に一致するか否かを検査することで、
  #worstcase time complexityを題意のオーダーで収めることができる。
  
    return if first >= last

    center = ( first + last ) / 2

    merge_sort( first , center)
    merge_sort( center +1 , last )

    left = self[ first..center ] << 1_000_000_001 #あまり良い方法ではないですが、問題文から門番を設定
    right = self[ center + 1 .. last] <<  1_000_000_001
    l = r = 0

    for i in (first..last)
      if left[l] <= right[r]
        self[i] = left[l]
        l = l + 1
      else
        self[i] = right[r]
        r = r + 1
      end
    end
    
  end
end



def solution(array_A, int_N, array_B, int_M)
    array_A.merge_sort
    array_B.merge_sort
    i = 0
    j = 0
    ans = 0
    
    while i < int_N && j < int_M do
        case ( array_A[i] - array_B[j] ) <=> 0
            when -1  ; i = i + 1
            when 1   ; j = j + 1
            else     ; ans = array_A[i]
        end
        break if ans > 0
    end
    ans = -1 if ans == 0
    
    return ans
end


=begin
#以下はテスト用
 
#a = [3, 2, 1, 5, 3, 200]
a = Array(3..100000).map{|i| i*3}
b = Array(70..10000).map{|i| i**2}.reverse
n = a.length
m = b.length
answer = solution(a, n, b, m)
puts answer

=end