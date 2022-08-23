module AlphaEstimators

export alphas, alvaro_test


function α(x::AbstractVector)
    n = length(x)
    m = floor(Int, n/2)
    s = sortperm(x)
    return sum(s[(n-m+1):n]) - sum(s[1:m])
end


function alphas(X::AbstractVector; n = 2)
    L = length(X)
    return [α(X[i:i+(n-1)]) for i in 1:(n-1):(L-n+1)]
end

### tests
using Distributions, HypothesisTests, StatsPlots

"""
    alvaro_test(X::AbstractVector; n = 2) -> (test, qqplot)

Anderson-Darling test of H₀: α ∼ N(0, sqrt(m^2*(2m+1)/3))
"""

function alvaro_test(X::AbstractVector; n = 2)
    m = floor(n/2)
    σ=sqrt(m^2*(2m+1)/3)
    test = OneSampleADTest(alphas(X; n = n), Normal(0, σ))
    return (test = test, qqplot = qqplot(
        Normal(0, σ), alphas(X; n = n)))
    
end

end # module AlphaEstimators
