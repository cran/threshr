## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

## ----include = FALSE----------------------------------------------------------
set.seed(22082017)

## ----fig.show='hold', fig.height=5, fig.width=7, fig.align='center'-----------
library(threshr)

# Set the size of the posterior sample simulated at each threshold
n <- 10000

## North Sea significant wave heights

# Set a vector of training thresholds
u_vec_ns <- quantile(ns, probs = seq(0.1, 0.85, by = 0.05))
# Compare the predictive performances of the training thresholds
ns_cv <- ithresh(data = ns, u_vec = u_vec_ns, n = n)

## Gulf of Mexico significant wave heights

# Set a vector of training thresholds
u_vec_gom <- quantile(gom, probs = seq(0.1, 0.8, by = 0.05))
# Compare the predictive performances of the training thresholds
gom_cv <- ithresh(data = gom, u_vec = u_vec_gom, n = n)

## ----fig.show='hold', fig.height=5, fig.width=7, fig.align='center', fig.alt = "Predictive threshold selections plots for the North Sea and Gulf of Mexico data. The thresholds with the best estimated performance are the 25% sample quantile for the North Sea data and the 60% sample quantile for the Gulf of Mexico data."----
plot(ns_cv, lwd = 2, cex.axis = 0.8)
mtext("North Sea : significant wave height / m", side = 3, line = 2.5)

plot(gom_cv, lwd = 2, cex.axis = 0.8)
mtext("Gulf of Mexico: significant wave height / m", side = 3, line = 2.5)

## -----------------------------------------------------------------------------
summary(ns_cv)
summary(gom_cv)

## ----fig.show='hold', fig.width=3.45, fig.height=3.45, fig.alt = "Plots of the posterior samples and contours of the posterior densities at the best thresholds for the North Sea (left) and Gulf of Mexico (right). Both plots exhibit negative posterior dependence between the GP scale and shape parameters."----
# Plot of Generalized Pareto posterior sample at the best threshold
# (based on the lowest validation threshold)
plot(ns_cv, which_u = "best")
plot(gom_cv, which_u = "best")

## ----fig.show='hold', fig.height=5, fig.width=7, fig.align='center', fig.alt = "Plots of the posterior predictive densities of the 100-year and 1000-year maxima for the Gulf of Mexico data. Both density functions are strongly positively skewed."----
# Predictive distribution function
best_p <- predict(gom_cv, n_years = c(100, 1000), type = "d")
plot(best_p)

## ----fig.show='hold', fig.height=5, fig.width=7, fig.align='center', fig.alt = "Plots of the distribution function of the 100-year maxima for the Gulf of Mexico data: one grey curve for each threshold and a black curve for the weighted average over all the thresholds considered."----
### All thresholds plus weighted average of inferences over all thresholds
all_p <- predict(gom_cv, which_u = "all")
plot(all_p)

