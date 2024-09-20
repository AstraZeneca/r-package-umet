\name{emp.table}
\alias{emp.table}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{The empirical design
%%  ~~function to do ... ~~
}
\description{The empirical design uses marginal probabilities from toxicity and efficacy to make a dosing decision with a threshold set for efficacy rate differences and toxicity rate ratios.  Refer to D’Angelo et al. (2024) for more details of this approach. The thresholds have to be set for efficacy difference and toxicity ratio regarding the decision criteria to select low dose, consider high dose, and high dose. There is an option to only include admissible doses in the comparison.
}
\usage{
emp.table(n.lo, n.hi, eff.hi, eff.lo, tox.hi, tox.lo, emp.eff.lo.thresh, emp.eff.hi.thresh, emp.tox.lo.thresh, emp.tox.hi.thresh, check.admiss, c_T, c_E, phi_T, phi_E)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n.lo}{ integer (n.lo>0) specifying sample size of lower dose }
  \item{n.hi}{ integer (n.hi>0) specifying sample size of higher dose}
  \item{eff.hi}{ integer (0<=eff.hi<=n.hi) specifying efficacy count of higher dose }
  \item{eff.lo}{ integer (0<=eff.lo<=n.lo) specifying efficacy count of lower dose }
  \item{tox.hi}{ integer (0<=tox.hi<=n.hi) specifying toxicity count of higher dose }
  \item{tox.lo}{ integer (0<=tox.lo<=n.lo) specifying toxicity count of lower dose }
  \item{emp.eff.lo.thresh}{ numeric value (0<=emp.eff.lo.thresh<emp.eff.hi.thresh) specifying lower threshold set for efficacy difference for decision criteria }
  \item{emp.eff.hi.thresh }{ numeric value (0<=emp.eff.lo.thresh<emp.eff.hi.thresh) specifying higher threshold set for efficacy difference for decision criteria }
  \item{emp.tox.lo.thresh}{ numeric value (0<=emp.tox.lo.thresh<emp.tox.hi.thresh) specifying lower threshold set for toxicity ratio for decision criteria }
  \item{emp.tox.hi.thresh}{ numeric value (0<=emp.tox.lo.thresh<emp.tox.hi.thresh) specifying higher threshold set for toxicity ratio for decision criteria }
  \item{check.admiss}{character value ("Yes"/"No") to check if doses are admissible and will only compare them if both are admissible}
  \item{c_T}{ numeric value (0<=c_T<=1) specifying probability threshold for toxicity to indicate if admissible, suggest 0.95; only need to enter value if check.admiss="Yes"}
  \item{c_E}{ numeric value (0<=c_E<=1) specifying probability threshold for efficacy to indicate if admissible, suggest 0.90; only need to enter value if check.admiss="Yes" }
  \item{phi_T}{ numeric value (0<=phi_T<=1) specifying upper toxicity rate threshold; only need to enter value if check.admiss="Yes" }
  \item{phi_E}{ numeric value (0<=phi_E<=1) specifying lower efficacy rate threshold; only need to enter value if check.admiss="Yes"}
 }



\details{
%%  ~~ If necessary, more details than the description above ~~
}

\value{
Returns a list of the following:
\item{eff.lo.rate  }{Efficacy rate low dose}
\item{tox.lo.rate  }{Toxicity rate low dose}
\item{eff.hi.rate  }{Efficacy rate high dose}
\item{tox.hi.rate  }{Toxicity rate high dose}
\item{eff_diff  }{Efficacy difference}
\item{tox_rat  }{Toxicity ratio}
\item{clin.sel_dose.truth  }{Select dose (2=High/1=Low/0=Consider)}
\item{gonogo.sel  }{Dose selection}

}
\references{
D’Angelo, G., Gong, M., Marshall, J., Yuan, Y., & Li, X. (2024). U-MET: Utility-Based Dose Optimization Approach for Multiple-Dose Randomized Trial Designs. Statistics in Biopharmaceutical Research, 1–11.

Lin, R., Zhou, Y., Yan, F., Li, D., and Yuan, Y. (2020), "BOIN12: Bayesian Optimal Interval Phase I/II Trial Design for Utility-Based Dose Finding in Immunotherapy and Targeted Therapies," JCO Precis Oncol, 4.

}
\author{
Gina D'Angelo
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
emp.table(n.lo=30,n.hi=30,eff.hi=17,eff.lo=10,tox.hi=6,tox.lo=3,emp.eff.lo.thresh=.15,emp.eff.hi.thresh=.3,emp.tox.lo.thresh=1.5, emp.tox.hi.thresh=2,check.admiss="Yes",c_T=0.95,c_E=0.90,phi_T=0.35,phi_E=0.25)

emp.table(n.lo=30,n.hi=30,eff.hi=17,eff.lo=10,tox.hi=6,tox.lo=3,emp.eff.lo.thresh=.15,emp.eff.hi.thresh=.3,emp.tox.lo.thresh=1.5, emp.tox.hi.thresh=2,check.admiss="No")


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
\keyword{Empirical}
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
