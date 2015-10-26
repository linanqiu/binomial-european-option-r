# Binomial European Option Pricing in - `R`

with example of parallel CPU usage in `par-binomial.R`

## Quick Start:

The following function is provided:

```R
binomial_option(type, sigma, T, r, X, S, N)
```

where:

- `type`: 'put' for European Put, 'call' for European Call
- `sigma`: underlier volatility. 0.33 means 33% volatility
- `T`: time period. 1 = 1 year. 0.25 = 3 months.
- `X`: strike price
- `S`: current asset price
- `N`: number of periods. N = number of levels - 1. ie. a 3 period simulation will contain 4 levels (don't forget the root!)

## Example

```R
call = binomial_option(type='call', sigma=0.2, T=1, r=0.1, X=100, S=100, N=4)

$q
[1] 0.6013857

$stock
          [,1]      [,2]     [,3]     [,4]     [,5]
[1,] 100.00000   0.00000   0.0000   0.0000   0.0000
[2,]  90.48374 110.51709   0.0000   0.0000   0.0000
[3,]  81.87308 100.00000 122.1403   0.0000   0.0000
[4,]  74.08182  90.48374 110.5171 134.9859   0.0000
[5,]  67.03200  81.87308 100.0000 122.1403 149.1825

$option
          [,1]      [,2]     [,3]     [,4]     [,5]
[1,] 12.768397  0.000000  0.00000  0.00000  0.00000
[2,]  4.467558 18.807893  0.00000  0.00000  0.00000
[3,]  0.000000  7.616834 27.01733  0.00000  0.00000
[4,]  0.000000  0.000000 12.98610 37.45489  0.00000
[5,]  0.000000  0.000000  0.00000 22.14028 49.18247

$price
[1] 12.7684

$delta
[1] 0.7158231
```

Where:

- `call$q` is risk neutral probability
- `call$stock` is stock tree matrix
- `call$option` is binomial option tree matrix
- `call$price` is option price
- `call$delta` is option delta

`problems.R` contains usages of this package. `par-binomial.R` demonstrates a parallel usage of this package.
