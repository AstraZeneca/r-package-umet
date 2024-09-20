\name{admiss.dose}
\alias{admiss.dose}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Indicates if dose is admissible
%%  ~~function to do ... ~~
}
\description{This function indicates if a dose is admissible and should be considered for dose comparison. This function can be run prior to the other dose comparison functions to decide if the doses should be compared. Refer to Lin et al. (2020) for more details.
}
\usage{admiss.dose(n, eff, tox, c_T, c_E, phi_T, phi_E, dose)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{ integer (n>0) specifying the sample size }
  \item{eff}{ integer (0<=eff<=n) specifying the efficacy count }
  \item{tox}{ integer (0<=tox<=n) specifying toxicity count  }
  \item{c_T}{ numeric value (0<=c_T<=1) specifying probability threshold for toxicity to indicate if admissible, suggest 0.95 }
  \item{c_E}{ numeric value (0<=c_E<=1) specifying probability threshold for efficacy to indicate if admissible, suggest 0.90 }
  \item{phi_T}{ numeric value (0<=phi_T<=1) specifying upper toxicity threshold }
  \item{phi_E}{ numeric value (0<=phi_E<=1) specifying lower efficacy threshold}
  \item{dose}{ Dose level (high/low e.g.)}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Returns a list of the following:

\item{eff }{Efficacy rate}
\item{tox }{Toxicity rate}
\item{keep_dose }{Keep dose (1=yes, 0=no)}
\item{admiss.dose }{Admissible dose/Inadmissible dose}
\item{dose.level }{ Dose level (high/low e.g.)}



}
\references{
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
admiss.dose (n=30,eff=10,tox=3,c_T=0.95,c_E=0.90,phi_T=0.25,phi_E=0.30,"low")

admiss.dose (n=30,eff=17,tox=6,c_T=0.95,c_E=0.90,phi_T=0.25,phi_E=0.30,"high")

}
\keyword{Admissible dose}
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
