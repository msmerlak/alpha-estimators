using Pkg
Pkg.activate(".")

using Revise, AlphaEstimators
using StatsPlots, Distributions, HypothesisTests

using ARFIMA, StatsBase

# AR(1) 
X = arma(10000, .1, SVector(.9))

## ADF easily rejects unit root
ADFTest(X, :none, 1)

### An ACF plot also shows anti-correlation of the increments
plot(autocor(diff(X)))

##  Alvaro's test does not
plts = [alvaro_test(diff(X); n = n).qqplot for n = 2:4:20]
plot(plts...)