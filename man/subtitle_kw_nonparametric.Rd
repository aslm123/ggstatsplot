% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers_ggbetween_anova_subtitles.R
\name{subtitle_kw_nonparametric}
\alias{subtitle_kw_nonparametric}
\title{Making text subtitle for the Kruskal-Wallis test (nonparametric ANOVA)
(between-subjects designs).}
\usage{
subtitle_kw_nonparametric(data, x, y, messages = TRUE, k = 2,
  nboot = 100, conf.level = 0.95, conf.type = "norm", ...)
}
\arguments{
\item{data}{A dataframe (or a tibble) from which variables specified are to
be taken. A matrix or tables will \strong{not} be accepted.}

\item{x}{The grouping variable from the dataframe \code{data}.}

\item{y}{The response (a.k.a. outcome or dependent) variable from the
dataframe \code{data}.}

\item{messages}{Decides whether messages references, notes, and warnings are
to be displayed (Default: \code{TRUE}).}

\item{k}{Number of digits after decimal point (should be an integer)
(Default: \code{k = 2}).}

\item{nboot}{Number of bootstrap samples for computing confidence interval
for the effect size (Default: \code{100}).}

\item{conf.level}{Scalar between 0 and 1. If unspecified, the defaults return
\code{95\%} lower and upper confidence intervals (\code{0.95}).}

\item{conf.type}{A vector of character strings representing the type of
intervals required. The value should be any subset of the values \code{"norm"},
\code{"basic"}, \code{"perc"}, \code{"bca"}. For more, see \code{?boot::boot.ci}.}

\item{...}{Additional arguments (ignored).}
}
\description{
Making text subtitle for the Kruskal-Wallis test (nonparametric ANOVA)
(between-subjects designs).
}
\examples{
subtitle_kw_nonparametric(
  data = ggplot2::msleep,
  x = vore,
  y = sleep_rem
)
}
\author{
Indrajeet Patil
}
