# risk free probability calculation
q_prob = function(r, delta_t, sigma) {
  u = exp(sigma*sqrt(delta_t))
  d = exp(-sigma*sqrt(delta_t))

  return((exp(r*delta_t) - d)/(u-d))
}

# builds stock binomial tree
build_stock_tree = function(S, sigma, delta_t, N) {
  tree = matrix(0, nrow=N+1, ncol=N+1)

  u = exp(sigma*sqrt(delta_t))
  d = exp(-sigma*sqrt(delta_t))

  for (i in 1:(N+1)) {
    for (j in 1:i) {
      tree[i,j] = S * u^(j-1) * d^((i-1)-(j-1))
    }
  }
  return(tree)
}

# build binimial option price tree using continuously compounded interest
value_binomial_option = function(tree, sigma, delta_t, r, X, type) {
  q = q_prob(r, delta_t, sigma)

  option_tree = matrix(0, nrow=nrow(tree), ncol=ncol(tree))
  if(type == 'put') {
    option_tree[nrow(option_tree),] = pmax(X - tree[nrow(tree),], 0)
  } else {
    option_tree[nrow(option_tree),] = pmax(tree[nrow(tree),] - X, 0)
  }

  for (i in (nrow(tree)-1):1) {
    for(j in 1:i) {
      option_tree[i, j] = ((1-q)*option_tree[i+1,j] + q*option_tree[i+1,j+1])/exp(r*delta_t)
    }
  }
  return(option_tree)
}

# concatenate results
binomial_option = function(type, sigma, T, r, X, S, N) {
  q = q_prob(r=r, delta_t=T/N, sigma=sigma)
  tree = build_stock_tree(S=S, sigma=sigma, delta_t=T/N, N=N)
  option = value_binomial_option(tree, sigma=sigma, delta_t=T/N, r=r, X=X, type=type)
  delta = (option[2,2]-option[2,1])/(tree[2,2]-tree[2,1])
  return(list(q=q, stock=tree, option=option, price=option[1,1], delta=delta))
}

# Quick Start:
## type: 'put' for European Put, 'call' for European Call
## sigma: underlier volatility. 0.33 means 33% volatility
## T: time period. 1 = 1 year. 0.25 = 3 months.
## X: strike price
## S: current asset price
## N: number of periods. N = number of levels - 1. ie. a 3 period simulation will contain 4 levels (don't forget the root!)

# Output:
## by running:
### call = binomial_option(type='call', sigma=0.2, T=1, r=0.1, X=100, S=100, N=4)
## call$q is risk neutral probability
## call$stock is stock tree matrix
## call$option is binomial option tree matrix
## call$price is option price
## call$delta is option delta
