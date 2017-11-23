function mergepresorted(A::Array{Int64,1}, B::Array{Int64,1})
    if length(A) == 0
        return B
    elseif length(B) == 0
        return A
    elseif A[1] < B[1]
        return vcat([A[1]], mergepresorted(A[2:end], B))
    else
        return vcat([B[1]], mergepresorted(A, B[2:end]))
    end    
end

function mergesort2(A::Array{Int64,1})
    n=length(A)
    if !((n & (n - 1)) == 0)    #bitwise trick for power of 2 (NB also 0)
    while !((n & (n - 1)) == 0) #fill with zeros to power of 2
        A=vcat(A,0)
        n = length(A)
    end
    end
    if n == 1
        return A
    else
        m = convert(Int64,n/2)
        return mergepresorted(mergesort2(A[1:m]),mergesort2(A[m+1:n]))
    end
end
