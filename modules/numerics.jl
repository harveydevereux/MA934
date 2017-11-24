# functions relevant to the question
f(x) = sin.(exp.(x))
f¹(x) = exp.(x).*cos.(exp.(x))
fb(x) = BigFloat(sin.(BigFloat(exp.(x))))
fb¹(x) = BigFloat(exp(x).*sin.(BigFloat(exp.(x))))
f²(x) = exp.(x).*cos.(exp.(x))-sin.(exp.(x)).*exp.(2*x)

# 3-stencil Finite-difference
function finite_difference_3(f::Function,x,h)
    return (4.*f.(x+h)-3.*f.(x)-f.(x+2*h))./(2*h)
end

function bracket_bisection(f::Function,a,b,ϵ=eps())
    r=0.0
    Error = []
    while (b-a) > ϵ
        r = (a+b)/2.0
        if f(a)*f(r) > 0
            a = r
        else
            b = r
        end
        append!(Error,(abs(r-log(BigFloat(pi)))))
    end
    return r, Error
end

function newton_raphson(f::Function,f¹::Function,x,ϵ=eps())
    Error=[]
    while abs(f(x))>ϵ
        δ=-(f(x)./f¹(x))
        x += δ
        append!(Error,abs(x-BigFloat(log(BigFloat(pi)))))
    end
    return x,Error
end

function golden_search(f::Function,BR::Array{Float64,1}, ϵ=eps())
# takes bracketing interval of [a b c] for a<c<b
    Error = []
    x = 0
    ϕ=(sqrt(5)-1.0)/2.0
    a = BR[1]
    b = BR[2]
    c = BR[3]
    while (c-a) > ϵ
        append!(Error,abs(x-BigFloat(log(BigFloat(3*pi)/BigFloat(2.0)))))
        a = BR[1]
        b = BR[2]
        c = BR[3]
        if abs(c-b)>abs(b-a)
            x = b+(1-ϕ)*(c-b)
            if f(b)<f(x)
                BR = [a,b,x]
            else
                BR = [b,x,c]
            end
        else
            x = b-(1-ϕ)*(b-a)
            if f(b)<f(x)
                BR = [x,b,c]
            else
                BR = [a,x,b]
            end
        end
    end
    return x,Error
end
