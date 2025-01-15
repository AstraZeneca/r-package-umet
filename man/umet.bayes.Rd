\name{umet.bayes}
\alias{umet.bayes}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{U-MET Bayes method }
\description{
This function is based on the U-MET Bayesian approach where utilities of two doses are compared and the difference of the standardized utilities are calculated. A probability of the utility difference \eqn{u_\Delta^* = u^*(2) - u^*(1)} is estimated to assess if the difference is greater than 0 (\eqn{p(u_\Delta^* > 0)}) and prespecified probability cut-offs are set to make a dosing decision. Refer to D’Angelo et al. (2024) for more details of this approach.  There is an option to only include admissible doses in the comparison.
}
\usage{umet.bayes(n.lo, n.hi, eff.lo, tox.lo, eff.hi, tox.hi, delta1, alpha1, alpha2, C1, C2, u2, u3, check.admiss, c_T, c_E, phi_T, phi_E)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n.lo }{ integer (n.lo>0) specifying sample size of lower dose }
  \item{n.hi }{ integer (n.hi>0) specifying sample size of higher dose }
  \item{eff.lo }{ integer (0<=eff.lo<=n.lo) specifying efficacy count of lower dose }
  \item{tox.lo }{ integer (0<=tox.lo<=n.lo) specifying toxicity count of lower dose }
  \item{eff.hi }{ integer (0<=eff.hi<=n.hi) specifying efficacy count of higher dose }
  \item{tox.hi }{ integer (0<=tox.hi<=n.hi) specifying toxicity count of higher dose }
  \item{delta1 }{ numeric value (0<=delta1) specifying the minimum difference of the utility difference in hypothesis test }
  \item{alpha1 }{ numeric value (0<alpha1<alpha2<1) prespecified significance level set for selection of high dose }
  \item{alpha2 }{ numeric value (0<alpha1< alpha2<1) specifying prespecified significance level set for selection of low dose }
  \item{C1 }{ numeric value (0<C2<C1<1) specifying decision criteria for high dose, suggest C1=1-alpha1}
  \item{C2 }{ numeric value (0<C2<C1<1) specifying decision criteria for low dose, suggest C2=1-alpha2}
  \item{u2 }{ integer (0<=u2<=100, u2+u3 = 100) specifying utility score for no toxicity and no efficacy; u2+u3 = 100 is recommended }
  \item{u3}{ integer (0<=u3<=100, u2+u3 = 100) specifying utility score for toxicity and efficacy; u2+u3 = 100 is recommended }
   \item{check.admiss}{character value ("Yes"/"No") to check if doses are admissible and will only compare them if both are admissible}
  \item{c_T}{ numeric value (0<=c_T<=1) specifying probability threshold for toxicity to indicate if admissible, suggest 0.95; only need to enter       value if check.admiss="Yes"}
  \item{c_E}{ numeric value (0<=c_E<=1) specifying probability threshold for efficacy to indicate if admissible, suggest 0.90; only need to enter      value if check.admiss="Yes" }
  \item{phi_T}{ numeric value (0<=phi_T<=1) specifying upper toxicity rate threshold; only need to enter value if check.admiss="Yes" }
  \item{phi_E}{ numeric value (0<=phi_E<=1) specifying lower efficacy rate threshold; only need to enter value if check.admiss="Yes"}
}

\value{
Returns a list of the following:
 \item{eff.lo.rate  }{Efficacy rate low dose}
 \item{tox.lo.rate  }{Toxicity rate low dose}
 \item{eff.hi.rate  }{Efficacy rate high dose}
 \item{tox.hi.rate  }{Toxicity rate high dose}
 \item{pgo }{Prob(utility difference > delta1)}
 \item{diff }{Utility Difference (High-Low)}
 \item{stand.diff }{Standardized Utility Difference (High-Low)}
\item{gonogo }{Select dose (2=High/1=Low/0=Consider)}
\item{gonogo.sel }{Dose selection}

}
\references{
D’Angelo, G., Gong, M., Marshall, J., Yuan, Y., & Li, X. (2024). U-MET: Utility-Based Dose Optimization Approach for Multiple-Dose Randomized Trial Designs. Statistics in Biopharmaceutical Research, 1–11.

Lin, R., Zhou, Y., Yan, F., Li, D., and Yuan, Y. (2020), "BOIN12: Bayesian Optimal Interval Phase I/II Trial Design for Utility-Based Dose Finding in Immunotherapy and Targeted Therapies," JCO Precis Oncol, 4.

Sverdlov O, Ryeznik Y, Wu S. Exact Bayesian Inference Comparing Binomial Proportions, With Application to Proof-of-Concept Clinical Trials. Ther Innov Regul Sci. 2015 Jan;49(1):163-174.

}
\author{Gina D'Angelo}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
umet.bayes(n.lo=30,n.hi=30, eff.lo=10, tox.lo=3, eff.hi=17, tox.hi=6,delta1=0,alpha1=.2,alpha2=.34, C1=1-.2, C2=1-.34,u2=35, u3=65,check.admiss="Yes",c_T=0.95,c_E=0.90,phi_T=0.35,phi_E=0.25)

umet.bayes(n.lo=30,n.hi=30, eff.lo=10, tox.lo=3, eff.hi=17, tox.hi=6,delta1=0,alpha1=.2,alpha2=.34, C1=1-.2, C2=1-.34,u2=35, u3=65,check.admiss="No")


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
\keyword{ U-MET Bayesian}

