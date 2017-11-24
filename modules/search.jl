function print_LList(L::Nullable{LList})
    if isnull(get(L).next) # if next is null we must have finished on this node
        println(get(L).data)
    else # otherwise we print the current and continue recursively
        println(get(L).data) 
        return(print_LList(get(L).next))
    end
end


function search_LList(L::Nullable{LList}, S::Int64)
    if (get(L).data).key == S # found the key
        return get(L).data
    elseif isnull(get(L).next) # no such key exists
        return(Nullable{KVPair})
    else
        search_LList(get(L).next,S) # continue recursively
    end
end

function intervalmembership(L::Nullable{LList}, x::Float64)
    if isnull((get(L).next)) # must have reached the end point since the function looks forward
#			       x must be beyond the last interval
        return(Nullable{KVPair})
    elseif ((get(get(L).next)).data).value > x # check the next node if greater then x is in that
#						 interval
        return get(get(L).next).data
    else
        intervalmembership(get(L).next,x) # continue recursively
    end
end

function FTintervalmembership(FT::Nullable{FTree},x::Float64)
    if isnull(get(FT).left) == true && isnull(get(FT).right) == true # reached bottom node
        return get(FT).data
    else
        y = ((get(get(FT).left)).data).value # test left node
        if x<=y
            return FTintervalmembership(get(FT).left,x)
        else
            return FTintervalmembership(get(FT).right,x-y)
        end
    end
end
