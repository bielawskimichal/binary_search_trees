module Sort
  def merge_sort(ary)
    return ary if ary.length == 1

    left_half = merge_sort(ary[0...ary.length / 2])
    right_half = merge_sort(ary[ary.length / 2..])
    result = []
    until result.length == ary.length
      if left_half[0].nil?
        result += right_half
      elsif right_half[0].nil?
        result += left_half
      else
        result << (left_half[0] < right_half[0] ? left_half.shift : right_half.shift)
      end
    end
    result
  end
end
