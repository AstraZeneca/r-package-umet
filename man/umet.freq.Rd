\name{umet.freq}
\alias{umet.freq}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{U-MET frequentist method}
\description{This function is based on the U-MET frequentist approach where utilities of two doses are compared and the difference of the standardized utilities (\eqn{u_\Delta^* = u^*(2) - u^*(1)}) are calculated. A one-sided confidence interval is estimated to assess if 0 is contained and thresholds are set to make a dosing decision.  Refer to D’Angelo et al. (2024) for more details of this approach. There is an option to only include admissible doses in the comparison.}
\usage{umet.freq(n.lo, eff.lo, tox.lo, n.hi, eff.hi, tox.hi, alpha1, alpha2, u2, u3, check.admiss, c_T, c_E, phi_T, phi_E)}
%- maybe also 'usage' for other objects documented here.
\arguments{

\item{n.lo }{ integer (n.lo>0) specifying sample size of lower dose}
\item{eff.lo }{ integer (0<=eff.lo<=n.lo) specifying efficacy count of lower dose}
\item{tox.lo }{ integer (0<=tox.lo<=n.lo) specifying toxicity count of lower dose}
\item{n.hi }{ integer (n.hi>0) specifying sample size of higher dose}
\item{eff.hi }{integer (0<=eff.hi<=n.hi) specifying efficacy count of higher dose}
\item{tox.hi }{ integer (0<=tox.hi<=n.hi) specifying toxicity count of higher dose}
\item{alpha1 }{ numeric value (0<alpha1<alpha2<1) prespecified significance level set for selection of high dose }
\item{alpha2 }{ numeric value (0<alpha1< alpha2<1) specifying prespecified significance level set for selection of low dose }
\item{u2 }{ integer (0<=u2<=100, u2+u3 <= 100) specifying utility score for no toxicity and no efficacy; u2+u3 = 100 is recommended }
\item{u3 }{ integer (0<=u3<=100, u2+u3 <= 100) specifying utility score for toxicity and efficacy; u2+u3 = 100 is recommended }
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
 \item{u.low }{Lower Dose Utility}
 \item{u.high }{Higher Dose Utility}
 \item{u.diff }{Utility Difference (High-Low)}
 \item{ustar.diff }{Standardized Utility Difference (High-Low)}
 \item{consider_a2 }{Consider Boundary}
 \item{go }{Go Boundary}
 \item{gonogo }{Select dose (2=High/1=Low/0=Consider) }
 \item{gonogo.sel }{Dose selection}

}
\references{
D’Angelo, G., Gong, M., Marshall, J., Yuan, Y., & Li, X. (2024). U-MET: Utility-Based Dose Optimization Approach for Multiple-Dose Randomized Trial Designs. Statistics in Biopharmaceutical Research, 1–11.

Lin, R., Zhou, Y., Yan, F., Li, D., and Yuan, Y. (2020), "BOIN12: Bayesian Optimal Interval Phase I/II Trial Design for Utility-Based Dose Finding in Immunotherapy and Targeted Therapies," JCO Precis Oncol, 4. }
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
umet.freq(n.lo=30,eff.lo=10,tox.lo=3,n.hi=30,eff.hi=17,tox.hi=6,alpha1=0.2,alpha2=0.34,u2=35,u3=65,check.admiss="Yes",c_T=0.95,c_E=0.90,phi_T=0.35,phi_E=0.25)

umet.freq(n.lo=30,eff.lo=10,tox.lo=3,n.hi=30,eff.hi=17,tox.hi=6,alpha1=0.2,alpha2=0.34,u2=35,u3=65,check.admiss="No")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
\keyword{U-MET Frequentist }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
