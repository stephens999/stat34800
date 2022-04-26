// This stan file defines the normal means model with normal prior, but using a reparameterization
// where the parameters are independent in the prior
data {
  int<lower=0> J;         // number of schools
  real y[J];              // estimated treatment effects
  real<lower=0> s[J]; // standard error of effect estimates
}

parameters {
  real mu;                // population treatment effect
  real<lower=0> sigma;      // standard deviation in treatment effects
  vector[J] eta;          // unscaled deviation from mu by school
}

model {
  mu ~ normal(0, 100); // a diffuse prior on the mean
  sigma ~ cauchy(0, 10); // another diffuse prior (note that sigma is bounded so this is "half-cauchy prior")
  eta ~ normal(0, 1);
  y ~ normal(mu + sigma * eta, s);
}
