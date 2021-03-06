\name{prepare.nbp}
\alias{prepare.nbp}
\title{Prepare the Data Structure for Exact NB test for Two-Group Comparison}
\usage{
prepare.nbp(counts, grp.ids, lib.sizes = colSums(counts),
  norm.factors = NULL, thinning = TRUE, print.level = 1)
}
\arguments{
  \item{counts}{an \eqn{n} by \eqn{r} matrix of RNA-Seq
  read counts with rows corresponding to genes (exons, gene
  isoforms, etc) and columns corresponding to libraries
  (independent biological samples).}

  \item{grp.ids}{an \eqn{r} vector of treatment group
  identifiers (can be a vector of integers, chars or
  strings).}

  \item{lib.sizes}{library sizes, an \eqn{r} vector of
  numbers. By default, library sizes are estimated by
  column sums.}

  \item{norm.factors}{normalization factors, an \eqn{r}
  vector of numbers. If \code{NULL} (default), no
  normalization will be applied.}

  \item{thinning}{a boolean variable (i.e., logical). If
  \code{TRUE} (default), the counts will be randomly down
  sampled to make effective library sizes approximately
  equal.}

  \item{print.level}{a number, controls the amount of
  messages printed: 0 for suppressing all messages, 1
  (default) for basic progress messages, and 2 to 5 for
  increasingly more detailed messages.}
}
\value{
A list containing the following components:
\item{counts}{the count matrix, same as input.}
\item{lib.sizes}{column sums of the count matrix.}
\item{grp.ids}{a vector of identifiers of treatment groups,
same as input.} \item{eff.lib.sizes}{effective library
sizes, lib.sizes multiplied by the normalization factors.}
\item{pseudo.counts}{count matrix after thinning.}
\item{pseduo.lib.sizes}{effective library sizes of pseudo
counts, i.e., column sums of the pseudo count matrix
multiplied by the normalization.}
}
\description{
Create the NBP data structure, (optionally) normalize the
counts, and thin the counts to make the effective library
sizes equal.
}
\details{
Normalization

We take gene expression to be indicated by relative
frequency of RNA-Seq reads mapped to a gene, relative to
library sizes (column sums of the count matrix). Since the
relative frequencies sum to 1 in each library (one column
of the count matrix), the increased relative frequencies of
truly over expressed genes in each column must be
accompanied by decreased relative frequencies of other
genes, even when those others do not truly differently
express. Robinson and Oshlack (2010) presented examples
where this problem is noticeable.

A simple fix is to compute the relative frequencies
relative to effective library sizes---library sizes
multiplied by normalization factors. Many authors (Robinson
and Oshlack (2010), Anders and Huber (2010)) propose to
estimate the normalization factors based on the assumption
that most genes are NOT differentially expressed.

By default, \code{prepare.nbp} does not estimate the
normalization factors, but can incorporate user specified
normalization factors through the argument
\code{norm.factors}.

Library Size Adjustment

The exact test requires that the effective library sizes
(column sums of the count matrix multiplied by
normalization factors) are approximately equal. By default,
\code{prepare.nbp} will thin (downsample) the counts to
make the effective library sizes equal. Thinning may lose
statistical efficiency, but is unlikely to introduce bias.
}
\note{
Due to thinning (random downsampling of counts), two
identical calls to \code{prepare.nbp} may yield slightly
different results. A random number seed can be used to make
the results reproducible.
}
\examples{
## See the example for exact.nb.test
}
\seealso{
\code{\link{nbp.test}}
}

