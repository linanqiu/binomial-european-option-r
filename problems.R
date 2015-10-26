source('binomial.R')

option = binomial_option(type='put', sigma=0.33, T=1/4, r=0.05, X=48, S=50, N=3)

option_call = binomial_option(type='call', sigma=0.33, T=1, r=0.1, X=100, S=100, N=6)
option_put = binomial_option(type='put', sigma=0.33, T=1, r=0.1, X=100, S=100, N=6)
option_call$price - option_put$price

periods = seq(100, 120)
option_price_vary_period = function(period) {
  print(period)
  option = binomial_option(type='call', sigma=0.2, T=1, r=0, X=100, S=100, N=period)
  return(option$price)
}
values = sapply(periods, option_price_vary_period)
library(ggplot2)
data = as.data.frame(list(periods=periods, values=values))
plot = ggplot(data=data) + geom_line(aes(x=periods, y=values)) + labs(title="Call Value", x="Periods", y="Value")
plot
