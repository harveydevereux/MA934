function recursion_hom(c₁,c₂,a₁,a₂,steps,num_type="F64")
    if (num_type == "F64")
        convert(Float64,c₁)
        convert(Float64,c₂)
        convert(Float64,a₁)
        convert(Float64,a₂)
        a::Array{Float64,1} = zeros(steps)
        a[1] = a₁
        a[2] = a₂
        for i in 2:steps-1
            a[i+1] = c₁*a[i] + c₂*a[i-1]
        end
         return a
    elseif (num_type == "F32")
        convert(Float32,c₁)
        convert(Float32,c₂)
        convert(Float32,a₁)
        convert(Float32,a₂)
        b::Array{Float32,1} = zeros(steps)
        b[1] = a₁
        b[2] = a₂
        for i in 2:steps-1
            b[i+1] = c₁*b[i] + c₂*b[i-1]
        end
         return b
    elseif (num_type == "Big")	
    	c::Array{BigFloat,1} = zeros(steps)
        c[1] = a₁
        c[2] = a₂
        for i in 2:steps-1
            c[i+1] = BigFloat(c₁*c[i] + c₂*c[i-1])
        end
        return c
    else
	println("Enter num_type 'F64', 'F32', or 'Big' for arithmetic type. Got: ", num_type)
    end
end
