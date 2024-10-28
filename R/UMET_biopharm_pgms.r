####This program includes the approaches in the U-Met paper and admissible criteria from the BOIN12 paper:
# The empirical design: emp.table function
# U-MET frequentist method : umet.freq function
# U-MET bayes method in paper using exact beta difference: umet.bayes function
# admissible function to decide if doses are admissible and should be compared: admiss.dose function
#####

#references
#D’Angelo G, Gong M, Marshall J, Yuan Y, Li X. U-MET: Utility-Based Dose Optimization Approach for Multiple-Dose
#Randomized Trial Designs. Statistics in Biopharmaceutical Research. 2024. Published online June 1-15.

#Sverdlov O, Ryeznik Y, Wu S. Exact Bayesian Inference Comparing Binomial Proportions, With Application to Proof-of-
#Concept Clinical Trials. Therapeutic Innovation Regulatory Science. 2015;49(1):163-174


#admissible dose, indicates if admissible or not, need to set toxicity and efficacy threshold, and probability thresholds to indicate if admissible
#this is run for each dose separately
#n = sample size
#eff = efficacy count
#tox is toxicity count
#c_T,c_E = probability thresholds for toxicity and efficacy to indicate if admissible
#phi_T = upper toxicity threshold
#phi_E = lower efficacy threshold,
#' @export
admiss.dose <- function(n,eff,tox,c_T,c_E,phi_T,phi_E,dose) {
  if (n!=round(n)) stop("Error: n should be an integer")
  if (n<=0) stop("Error: check if n>0")
  if (eff!=round(eff)) stop("Error: eff should be an integer")
  if (eff>n || eff<0) stop("Error: check if 0<=eff<=n")
  if (tox!=round(tox)) stop("Error: tox should be an integer")
  if (tox>n || tox<0) stop("Error: check  if 0<=tox<=n")
  if (c_T>1 || c_T<0) stop("Error: check if 0<=c_T<=1")
  if (c_E>1 || c_E<0) stop("Error: check if 0<=c_E<=1")
  if (phi_T>1 || phi_T<0) stop("Error: check if 0<=phi_T<=1")
  if (phi_E>1 || phi_E<0) stop("Error: check if 0<=phi_E<=1")

n_t_d=tox
n_e_d=eff
keep_dose=ifelse((pbeta(phi_T, 1+n_t_d, 1+n - n_t_d, lower.tail=F) >= c_T)|(pbeta(phi_E, 1+n_e_d, 1+n - n_e_d, lower.tail=T) >= c_E),
                   0,1)
 admiss.dose=   ifelse(keep_dose==0,
                     "inadmissible","admissible")
 admiss.dose <-data.frame(eff=round(eff/n,3),
                     tox=round(tox/n,3),
                     keep_dose= keep_dose,
                     admiss.dose=admiss.dose,
                     dose.level=dose)
 colnames(admiss.dose)<-c("Efficacy rate", "Toxicity rate", "Keep dose (1=yes)", "Admissible dose", "Dose level")
 admiss.dose.t <- noquote(t(admiss.dose))
 colnames(admiss.dose.t) <- "Admissible output"
 return(noquote(admiss.dose.t))

}


#empirical table from paper, need sample size, efficacy and toxicity count data for high and low dose,
#thresholds set for efficacy difference and toxicity ratio for decision criteria to out in low dose, consider zone, and high dose
#count data is put in for eff and tox
#n.lo =  sample size of lower dose
#n.hi =  sample size of higher dose
#eff.hi = efficacy count of higher dose
#eff.lo = efficacy count of lower dose
#tox.hi = toxicity count of higher dose
#tox.lo = toxicity count of lower dose
#emp.eff.lo.thresh = lower thresholds set for efficacy difference for decision criteria
#emp.eff.hi.thresh = higher thresholds set for efficacy difference for decision criteria
#emp.tox.lo.thresh = lower thresholds set for toxicity ratio for decision criteria
#emp.tox.hi.thresh = higher thresholds set for toxicity ratio for decision criteria
#' @export
emp.table <- function(n.lo,n.hi,eff.hi,eff.lo,tox.hi,tox.lo,emp.eff.lo.thresh,emp.eff.hi.thresh,emp.tox.lo.thresh, emp.tox.hi.thresh,
                         check.admiss,c_T,c_E,phi_T,phi_E) {
  if (n.lo!=round(n.lo)) stop("Error: n.lo should be an integer")
  if (n.lo<=0) stop("Error: check if n.lo>0")
  if (n.hi!=round(n.hi)) stop("Error: n.hi should be an integer")
  if (n.hi<=0) stop("Error: check if n.hi>0")
  if (eff.hi!=round(eff.hi)) stop("Error: eff.hi should be an integer")
  if (eff.hi>n.hi || eff.hi<0) stop("Error: check if 0<=eff.hi<=n.hi")
  if (eff.lo!=round(eff.lo)) stop("Error: eff.lo should be an integer")
  if (eff.lo>n.lo || eff.lo<0) stop("Error: check if 0<=eff.lo<=n.lo")
  if (tox.hi!=round(tox.hi)) stop("Error: tox.hi should be an integer")
  if (tox.hi>n.hi || tox.hi<0) stop("Error: check if 0<=tox.hi<=n.hi")
  if (tox.lo!=round(tox.lo)) stop("Error: tox.lo should be an integer")
  if (tox.lo>n.lo || tox.lo<0) stop("Error: check if 0<=tox.lo<=n.lo")
  if (emp.eff.lo.thresh<0 || emp.eff.lo.thresh>=emp.eff.hi.thresh) stop("Error: check if 0<=emp.eff.lo.thresh<emp.eff.hi.thresh")
  if (emp.eff.hi.thresh<0 ) stop("Error: check if 0<=emp.eff.hi.thresh")
  if (emp.tox.lo.thresh<0 || emp.tox.lo.thresh>=emp.tox.hi.thresh) stop("Error: check if 0<=emp.tox.lo.thresh<emp.tox.hi.thresh")
  if (emp.tox.hi.thresh<0 ) stop("Error: check if 0<=emp.tox.hi.thresh")
  if (!check.admiss%in% c("Yes","No")) stop("Error: check.admiss should be Yes or No")
  if(check.admiss=="No") {c_T=0
                         c_E=0
                         phi_T=0
                        phi_E=0}
  if (check.admiss=="Yes") {
    if (c_T>1 || c_T<0) stop("Error: check if 0<=c_T<=1")
    if (c_E>1 || c_E<0) stop("Error: check if 0<=c_E<=1")
    if (phi_T>1 || phi_T<0) stop("Error: check if 0<=phi_T<=1")
    if (phi_E>1 || phi_E<0) stop("Error: check if 0<=phi_E<=1")
    if (as.numeric(admiss.dose(n.lo,eff.lo, tox.lo,c_T,c_E,phi_T,phi_E,"low")["Keep dose (1=yes)",])==0) stop("Low dose inadmissible")
    if (as.numeric(admiss.dose(n.hi,eff.hi, tox.hi,c_T,c_E,phi_T,phi_E,"high")["Keep dose (1=yes)",])==0) stop("High dose inadmissible")
  }
  #efficacy rate difference for clinical table
eff_diff=round(((eff.hi)/n.hi-(eff.lo)/n.lo),5)
#toxicity rate ratio for clinical table
tox_rat= round((((tox.hi)/n.hi)/((tox.lo)/n.lo)),5)
######empirical table table from 3x3 table
#if 2 then high dose selected, if 1 low dose selected, if 0 consider dose 2 but explore more
clin.sel_dose.truth=(2*as.numeric((eff_diff>=emp.eff.lo.thresh & tox_rat<emp.tox.lo.thresh)||(eff_diff>emp.eff.hi.thresh & emp.tox.lo.thresh<=tox_rat & tox_rat<=emp.tox.hi.thresh))) +
  (1*as.numeric((eff_diff<=emp.eff.hi.thresh & tox_rat>emp.tox.hi.thresh)||(eff_diff<emp.eff.lo.thresh & emp.tox.lo.thresh<=tox_rat & tox_rat<=emp.tox.hi.thresh)))+0
clin.sel_dose.truth <- as.integer(clin.sel_dose.truth)
gonogo.sel=   ifelse(clin.sel_dose.truth==2L,
                     "High dose",
                     ifelse(clin.sel_dose.truth==1L,
                            "Low dose","Consider high dose"))
#this gives 100*original utility in the paper
emp.dat<-data.frame(
                eff.lo.rate=round(eff.lo/n.lo,3),
                tox.lo.rate=round(tox.lo/n.lo,3),
                eff.hi.rate=round(eff.hi/n.hi,3),
                tox.hi.rate=round(tox.hi/n.hi,3),
                eff_diff=round(eff_diff,3),
                tox_rat=round(tox_rat,2),
                clin.sel_dose.truth=clin.sel_dose.truth,
                gonogo.sel=gonogo.sel)

colnames(emp.dat)<-c("Efficacy rate low dose", "Toxicity rate low dose","Efficacy rate high dose", "Toxicity rate high dose", "Efficacy difference", "Toxicity ratio", "Select dose (2=High/1=Low/0=Consider)", "Dose selection")
emp.dat.t <- noquote(t(emp.dat))
colnames(emp.dat.t) <- "Empirical table output"
return(emp.dat.t)
}


#U-MET frequentist method in paper

#frequentist approach
#n is sample size
#eff is efficacy count
#tox is toxicity count
#count data is passed through for eff and tox
util.freq <- function(n,eff,tox,u2,u3) {
  u.est=(u3*eff+u2*(n-tox))/100/n
  u.var<-u.est*(1-u.est)/n
  return(list(utility=u.est,u.var=u.var))
}
#n.lo =  sample size of lower dose
#eff.lo = efficacy count of lower dose
#tox.lo = toxicity count of lower dose
#n.hi =  sample size of higher dose
#eff.hi = efficacy count of higher dose
#tox.hi = toxicity count of higher dose
#count data is passed through for eff and tox
#' @export
umet.freq <- function(n.lo,eff.lo,tox.lo,n.hi,eff.hi,tox.hi,alpha1,alpha2,u2,u3,check.admiss,c_T,c_E,phi_T,phi_E) {
  if (n.lo!=round(n.lo)) stop("Error: n.lo should be an integer")
  if (n.lo<=0) stop("Error: check if n.lo>0")
  if (eff.lo!=round(eff.lo)) stop("Error: eff.lo should be an integer")
  if (eff.lo>n.lo || eff.lo<0) stop("Error: check if 0<=eff.lo<=n.lo")
  if (tox.lo!=round(tox.lo)) stop("Error: tox.lo should be an integer")
  if (tox.lo>n.lo || tox.lo<0) stop("Error: check if 0<=tox.lo<=n.lo")
  if (n.hi!=round(n.hi)) stop("Error: n.hi should be an integer")
  if (n.hi<=0) stop("Error: check if n.hi>0")
  if (eff.hi!=round(eff.hi)) stop("Error: eff.hi should be an integer")
  if (eff.hi>n.hi || eff.hi<0) stop("Error: check if 0<=eff.hi<=n.hi")
  if (tox.hi!=round(tox.hi)) stop("Error: tox.hi should be an integer")
  if (tox.hi>n.hi || tox.hi<0) stop("Error: check if 0<=tox.hi<=n.hi")
  if (alpha1<=0 || alpha1>=1 ) stop("Error: check if 0<alpha1<1")
  if (alpha2<=0 || alpha2>=1 ) stop("Error: check if 0<alpha2<1")
  if (alpha2<=alpha1 ) stop("Error: check if alpha1<alpha2")
  if (u2!=round(u2)) stop("Error: u2 should be an integer")
  if (u2<0 || u2>100) stop("Error: check if 0<=u2<=100")
  if (u3!=round(u3)) stop("Error: u3 should be an integer")
  if (u3<0 || u3>100) stop("Error: check if 0<=u3<=100")
  if (u2+u3>100) stop("Error: check if u2+u3<=100")
  if (!check.admiss%in% c("Yes","No")) stop("Error: check.admiss should be Yes or No")
  if(check.admiss=="No") {c_T=0
                         c_E=0
                         phi_T=0
                        phi_E=0}
  if (check.admiss=="Yes") {
    if (c_T>1 || c_T<0) stop("Error: check if 0<=c_T<=1")
    if (c_E>1 || c_E<0) stop("Error: check if 0<=c_E<=1")
    if (phi_T>1 || phi_T<0) stop("Error: check if 0<=phi_T<=1")
    if (phi_E>1 || phi_E<0) stop("Error: check if 0<=phi_E<=1")
    if (as.numeric(admiss.dose(n.lo,eff.lo, tox.lo,c_T,c_E,phi_T,phi_E,"low")["Keep dose (1=yes)",])==0) stop("Low dose inadmissible")
    if (as.numeric(admiss.dose(n.hi,eff.hi, tox.hi,c_T,c_E,phi_T,phi_E,"high")["Keep dose (1=yes)",])==0) stop("High dose inadmissible")
  }
  #this gives 100*original utility in the paper
  df2<-data.frame(
    eff.lo.rate=round(eff.lo/n.lo,3),
    tox.lo.rate=round(tox.lo/n.lo,3),
    eff.hi.rate=round(eff.hi/n.hi,3),
    tox.hi.rate=round(tox.hi/n.hi,3),
    u.low=round(100*util.freq(n.lo,eff.lo,tox.lo,u2,u3)[[1]],2),
                  u.high=round(100*util.freq(n.hi,eff.hi,tox.hi,u2,u3)[[1]],2),
                  u.diff=round(100*util.freq(n.hi,eff.hi,tox.hi,u2,u3)[[1]]-100*util.freq(n.lo,eff.lo,tox.lo,u2,u3)[[1]],2),
                  ustar.diff=round(util.freq(n.hi,eff.hi,tox.hi,u2,u3)[[1]]-util.freq(n.lo,eff.lo,tox.lo,u2,u3)[[1]],4),
                  consider_a2=round(100*qnorm(1-alpha2)*sqrt(util.freq(n.lo,eff.lo,tox.lo,u2,u3)$u.var + util.freq(n.hi,eff.hi,tox.hi,u2,u3)$u.var),2),
                  go=round(100*(qnorm(1-alpha1)*sqrt(util.freq(n.lo,eff.lo,tox.lo,u2,u3)$u.var + util.freq(n.hi,eff.hi,tox.hi,u2,u3)$u.var)),2))
      df2$gonogo=2*(df2$u.diff>df2$go)+ 1*(df2$u.diff<df2$consider_a2)+ 0*(df2$go>=df2$u.diff & df2$u.diff>=df2$consider_a2)
      df2$gonogo.sel=   ifelse(df2$gonogo==2,
                         "High dose",
                         ifelse(df2$gonogo==1,
                                "Low dose","Consider high dose"))
      colnames(df2)<-c("Efficacy rate low dose", "Toxicity rate low dose","Efficacy rate high dose", "Toxicity rate high dose", "Lower Dose Utility", "Higher Dose Utility", "Utility Difference (High-Low)","Standardized Utility Difference (High-Low)", "Consider Boundary", "Go Boundary","Select dose (2=High/1=Low/0=Consider)", "Dose selection")
      df2.t <- noquote(t(df2))
      colnames(df2.t) <- "U-MET Frequentist output"
      return(df2.t)
}


####U-MET bayes method in paper, exact beta difference
#count data is passed through for eff and tox
#n.lo =  sample size of lower dose
#n.hi =  sample size of higher dose
#eff.lo = efficacy count of lower dose
#tox.lo = toxicity count of lower dose
#eff.hi = efficacy count of higher dose
#tox.hi = toxicity count of higher dose
#delta1 = the minimum difference of the utility difference in hypothesis test
#C1 =  decision criteria for high dose, 1-alpha1
#C2 = decision criteria for low dose, 1-alpha2
#u2 = utility score for no toxicity and no efficacy
#u3 = utility score for toxicity and efficacy; u2+u3 <= 100, recommended to have u2+u3 = 100
#' @export
umet.bayes <- function(n.lo,n.hi, eff.lo, tox.lo, eff.hi, tox.hi,
                            delta1,alpha1,alpha2, C1, C2,u2, u3,check.admiss,c_T,c_E,phi_T,phi_E){
  if (n.lo!=round(n.lo)) stop("Error: n.lo should be an integer")
  if (n.lo<=0) stop("Error: check if n.lo>0")
  if (n.hi!=round(n.hi)) stop("Error: n.hi should be an integer")
  if (n.hi<=0) stop("Error: check if n.hi>0")
  if (eff.hi!=round(eff.hi)) stop("Error: eff.hi should be an integer")
  if (eff.hi>n.hi || eff.hi<0) stop("Error: check if 0<=eff.hi<=n.hi")
  if (eff.lo!=round(eff.lo)) stop("Error: eff.lo should be an integer")
  if (eff.lo>n.lo || eff.lo<0) stop("Error: check if 0<=eff.lo<=n.lo")
  if (tox.hi!=round(tox.hi)) stop("Error: tox.hi should be an integer")
  if (tox.hi>n.hi || tox.hi<0) stop("Error: check if 0<=tox.hi<=n.hi")
  if (tox.lo!=round(tox.lo)) stop("Error: tox.lo should be an integer")
  if (tox.lo>n.lo || tox.lo<0) stop("Error: check if 0<=tox.lo<=n.lo")
  if (delta1<0) stop("Error: check if 0<=delta")
  if (alpha1<=0 || alpha1>=1 ) stop("Error: check if 0<alpha1<1")
  if (alpha2<=0 || alpha2>=1 ) stop("Error: check if 0<alpha2<1")
  if (alpha2<=alpha1 ) stop("Error: check if alpha1<alpha2")
  if (C1<=0 || C1>=1 ) stop("Error: check if 0<C1<1")
  if (C2<=0 || C2>=1 ) stop("Error: check if 0<C2<1")
  if (C1<=C2 ) stop("Error: check if C2<C1")
  if (u2!=round(u2)) stop("Error: u2 should be an integer")
  if (u2<0 || u2>100) stop("Error: check if 0<=u2<=100")
  if (u3!=round(u3)) stop("Error: u3 should be an integer")
  if (u3<0 || u3>100) stop("Error: check if 0<=u3<=100")
  if (u2+u3>100) stop("Error: check if u2+u3<=100")
  if (!check.admiss%in% c("Yes","No")) stop("Error: check.admiss should be Yes or No")
  if(check.admiss=="No") {c_T=0
                         c_E=0
                         phi_T=0
                           phi_E=0}
  if (check.admiss=="Yes") {
    if (c_T>1 || c_T<0) stop("Error: check if 0<=c_T<=1")
    if (c_E>1 || c_E<0) stop("Error: check if 0<=c_E<=1")
    if (phi_T>1 || phi_T<0) stop("Error: check if 0<=phi_T<=1")
    if (phi_E>1 || phi_E<0) stop("Error: check if 0<=phi_E<=1")
    if (as.numeric(admiss.dose(n.lo,eff.lo, tox.lo,c_T,c_E,phi_T,phi_E,"low")["Keep dose (1=yes)",])==0) stop("Low dose inadmissible")
    if (as.numeric(admiss.dose(n.hi,eff.hi, tox.hi,c_T,c_E,phi_T,phi_E,"high")["Keep dose (1=yes)",])==0) stop("High dose inadmissible")
  }
  # Pseudo-response data
  x.lo=(u3*eff.lo+u2*(n.lo-tox.lo))/100
  x.hi=(u3*eff.hi+u2*(n.hi-tox.hi))/100
  # calculate the probability that udiff is greater than delta1
  pgo <- 1-p2beta(relation='DIFF', approach='DIRECT', x = delta1,
                  a1 = 1+x.lo, b1 = 1+n.lo-x.lo,
                  a2 = 1+x.hi, b2 = 1+n.hi-x.hi)
  # if pgo > C1 then choose high
  # if pgo < C2 then choose low
  #else consider zone
  gonogo <- ifelse(pgo > C1,
                   2,
                   ifelse(pgo < C2,
                          1, 0))
  gonogo.sel <- ifelse(pgo > C1,
                   "High dose",
                   ifelse(pgo < C2,
                        "Low dose","Consider high dose"))
  df3<-data.frame(
    eff.lo.rate=round(eff.lo/n.lo,3),
    tox.lo.rate=round(tox.lo/n.lo,3),
    eff.hi.rate=round(eff.hi/n.hi,3),
    tox.hi.rate=round(tox.hi/n.hi,3),
    pgo=round(pgo,4),
                  diff= round(100*(x.hi/n.hi-x.lo/n.lo),2),
                  stand.diff= round((x.hi/n.hi-x.lo/n.lo),4),
                  gonogo=gonogo,
                  gonogo.sel=gonogo.sel)
  colnames(df3)<-c("Efficacy rate low dose", "Toxicity rate low dose","Efficacy rate high dose", "Toxicity rate high dose", "Prob(utility difference > delta1)", "Utility Difference (High-Low)", "Standardized Utility Difference (High-Low)", "Select dose (2=High/1=Low/0=Consider)", "Dose selection")

  df3.t <- noquote(t(df3))
  colnames(df3.t) <- "U-MET Bayesian output"
  return(df3.t)
}
