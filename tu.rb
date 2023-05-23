def check_str(arr)
	if arr.length ==2 and arr.all?{ |i| i.is_a?(String) && i.length > 0 }
		puts arr[0].include?arr[1].chars.uniq.sort.join 
	else
		puts false
	end
end	

arr1=["abcxyz","cabababxzycc"]
arr2= ["ab","bacz"]

check_str(arr1)
check_str(arr2)