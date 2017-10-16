###################################################################
#
# R source code providing generalized bilinear mixed effects modeling
# for social network data. For more information on the model fitting 
# procedure, see 
# "Bilinear Mixed-Effects Models for Dyadic Data" (Hoff 2003)
# http://www.stat.washington.edu/www/research/reports/2003/tr430.pdf
#
# This research was supported by ONR grant N00014-02-1-1011 
#
# Copyright (C) 2003 Peter D. Hoff
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, 
# Boston, MA  02111-1307, USA.
#
##################################################################

###Last modification : 2/22/04

###Preconditions of the main function "gbme"

##objects with no defaults
#Y : a square matrix (n*n)

##objects with defaults
#Xd : an n*n*rd array representing dyad-specific predictors
#Xs : an n*rs matrix of sender-specific predictors
#Xr : an n*rr matrix of receiver-specific predictors

# fam : "gaussian" "binomial", or "poisson"
# if fam="binomial" then an (n*n) matrix N of trials is needed
#
# pi.Sab = (s2a0,sab0,s2b0,v0) : parameters of inverse wishart dist
# pi.s2u = vector of length 2: parameters of an inv-gamma distribution
# pi.s2v = vector of length 2: parameters of an inv-gamma distribution
# pi.s2z = k*2 matrix : parameters of k inv-gamma distributions
#
# pim.bd  : vector of length rd, the prior mean for beta.d
# piS.bd  : a rd*rd pos def matrix, the prior covariance for beta.d
#
# pim.b0sr : vector of length 1+rs+rr, prior mean for (beta0,beta.s,beta.r)
# piS.b0sr  : a (1+rs+rr)*(1+rs+rr) pos def matrix, 
#             the prior variance for (beta0,beta.s,beta.r)

# k     : dimension of latent space
# directed : T or F. Is the data directed or undirected? If set to F, 
#                    estimation proceeds assuming Y[i,j]==Y[j,i], 
#                    and any supplied value of Xr is not used 
#                    also, only s2a0 and v0 in pi.Sab need be supplied, 
#                    and pi.s2v is not used. rr is zero, so pim.b0sr is 
#                    length 1+rs 

# starting values
# beta.d   #a vector of length rd
# beta.u   #a vector of length 1+rs+rr
# s        #a vector of length n
# r        #a vector of length n 
# z        #an n*k matrix

###the main  function
gbme<-function(
 #data 
 Y,  
 Xd=array(dim=c(n,n,0)),
 Xs=matrix(nrow=dim(Y)[1],ncol=0),
 Xr=matrix(nrow=dim(Y)[1],ncol=0),  

 #model specification
 fam="gaussian",         
 N=NULL, 
 k=0,
 directed=T, 

#compute starting values and emp Bayes for priors?
 estart=T, 
 
#priors  - provide if estart=F
 pi.Sab=NULL,
 pi.s2u=NULL,
 pi.s2v=NULL,
 pi.s2z=NULL,
 pim.bd=NULL,
 piS.bd=NULL,
 pim.b0sr=NULL,
 piS.b0sr=NULL,
 
 #starting values - provide if estart=F 
 beta.d=NULL,
 beta.u=NULL,
 s=NULL,
 r=NULL,
 z=NULL,

 #random seed, 
 seed=0,

 #details of output
 NS=100000,         #number of scans of mcmc to run
 odens=100,         #output density
 owrite=T,          #write output to a file? 
 ofilename="OUT",   #name of output file 
 oround=3,          #rounding of output
 zwrite=(k>0),      #write z to  file 
 zfilename="Z",     #outfile for z 
 sdigz=3,           #rounding for z
 awrite=F,bwrite=F,
 afilename="A",
 bfilename="B"
	       )
{

###set seed
set.seed(seed)
                                                                                


###dimensions of everything
n<<-dim(Y)[1]
rd<<-dim(Xd)[3]
rs<<-dim(Xs)[2]
rr<<-dim(Xr)[2]   
diag(Y)<<-rep(0,n)
###

###column names for output file
if(directed==T) {
cnames<-c("k","scan","ll",paste("bd",seq(1,rd,length=rd),sep="")[0:rd],"b0",
                          paste("bs",seq(1,rs,length=rs),sep="")[0:rs],
                          paste("br",seq(1,rr,length=rr),sep="")[0:rr],
  "s2a","sab","s2b","s2e","rho", paste("s2z",seq(1,k,length=k),sep="")[0:k] )
                } 
            
if(directed==F) {
cnames<-c("k","scan","ll",paste("bd",seq(1,rd,length=rd),sep="")[0:rd],"b0",
                          paste("bs",seq(1,rs,length=rs),sep="")[0:rs],
                "s2a","s2e",paste("s2z",seq(1,k,length=k),sep="")[0:k] )
                }

                 
###design matrix for unit-specific predictors
if(directed==T) {
X.u<<-rbind( cbind( rep(.5,n), Xs, matrix(0,nrow=n,ncol=rr)),
            cbind( rep(.5,n),  matrix(0,nrow=n,ncol=rs), Xr ) )
                 }

if(directed==F) { X.u<<-cbind( rep(.5,n), Xs )  }
###

###construct an upper triangular matrix (useful for later computations)
tmp<-matrix(1,n,n)
tmp[lower.tri(tmp,diag=T)]<-NA 
UT<<-tmp
###


###get starting values and empirical bayes priors using a glm-type approach
if(estart==T) {tmp<-gbme.glmstart(Y,Xd,Xs,Xr,N=N,fam,k,directed)
               priors<-tmp$priors ; startv<-tmp$startv 
              }

if(directed==T) {
 pi.Sab<-priors$pi.Sab; pi.s2u<-priors$pi.s2u; pi.s2v<-priors$pi.s2v
 pi.s2z<-priors$pi.s2z ; pim.bd<-priors$pim.bd ; piS.bd<-priors$piS.bd
 pim.b0sr<-priors$pim.b0sr ; piS.b0sr<-priors$piS.b0sr 
 beta.d<-startv$beta.d ; beta.u<-startv$beta.u 
 s<-startv$s ; r<-startv$r ; z<-startv$z
               }
###

if(directed == F) {  rho<-1  ;sv<-0 ;  Xr<-Xs ; rr<-rs 
                  pi.s2u<-priors$pi.s2u ; pi.s2z<-priors$pi.s2z 
                  pim.bd<-priors$pim.bd ; piS.bd<-priors$piS.bd
                  beta.d<-startv$beta.d ; beta.u<-startv$beta.u ; z<-startv$z
                  s<-startv$s ; 
                  pi.s2a<-priors$pi.s2a ; 
                  pim.b0s<-priors$pim.b0s ;  piS.b0s<-priors$piS.b0s 
                  Xr<-NULL ; rr<-0 ; r<-s*0   }

 
###Matrices for ANOVA  on Xd, s, r
tmp<-TuTv(n)   #unit level effects design matrix for u=yij+yji, v=yij-yji
Tu<-tmp$Tu
Tv<-tmp$Tv

if(directed==F) { Tu<-2*Tu[,1:n] }

tmp<-XuXv(Xd)   #regression design matrix for u=yij+yji, v=yij-yji
Xu<-tmp$Xu  
Xv<-tmp$Xv

XTu<<-cbind(Xu,Tu)
XTv<<-cbind(Xv,Tv)

tXTuXTu<<-t(XTu)%*%XTu
tXTvXTv<<-t(XTv)%*%XTv
###


###redefining hyperparams
if(directed==T){
Sab0<-matrix( c(pi.Sab[1],pi.Sab[2],pi.Sab[2],pi.Sab[3]),nrow=2,ncol=2) 
v0<-pi.Sab[4]   }
###

###initializing error matrix
E<-matrix(0,nrow=n,ncol=n)
###

###if using the linear link, then theta=Y
if(fam=="gaussian"){ theta<-Y }
###


##### The Markov chain Monte Carlo algorithm
for(ns in 1:NS){

###update value of theta
if(fam!="gaussian"){theta<-theta.betaX.d.srE.z(beta.d,Xd,s,s*(1-directed)+r*directed,E,z)  }

###impute any missing values if gaussian
if(fam=="gaussian" & any(is.na(Y))) {  
  rho<-(pi.s2u[2]-pi.s2v[2])/(pi.s2u[2]+pi.s2v[2])
  se<-(pi.s2u[2]+pi.s2v[2])/4
  mu<-theta.betaX.d.srE.z(beta.d,Xd,s,s*(1-directed)+r*directed,E*0,z)
  imiss<-(1:n)[ is.na(Y%*%rep(1,n))  ]
  for(i in imiss){
    for(j in (1:n)[is.na(Y[i,])]) {
    if( is.na(Y[i,j]) & is.na(Y[j,i]) )       {
      smp<-rmvnorm(c(mu[i,j],mu[j,i]),matrix( se*c(1,rho,rho,1),nrow=2,ncol=2))
      theta[i,j]<-smp[1] ; theta[j,i]<-smp[2] }
else{theta[i,j]<-rmvnorm( mu[i,j]+rho*(theta[j,i]-mu[j,i]), sqrt(se*(1-rho^2)))}
                                   }  
                  }           
                                    }  


###Update regression part
tmp<-uv.E(theta-z%*%t(z)) #the regression part
u<-tmp$u                  #u=yij+yji,  i<j
v<-tmp$v                  #v=yij-yji,  i<j

#First get variance - covariance terms
if(directed==T) {
su<-rse.beta.d.gibbs(pi.s2u[1],pi.s2u[2],u,XTu,s,r,beta.d)  #for rho, se
sv<-rse.beta.d.gibbs(pi.s2v[1],pi.s2v[2],v,XTv,s,r,beta.d)
rho<-(su-sv)/(su+sv)
se<-(su+sv)/4
                 }
if(directed==F) {
su<-rse.beta.d.gibbs(pi.s2u[1],pi.s2u[2],u,XTu,s,NULL,beta.d) #for se
se<-su/4       }


sr.hat<-X.u%*%beta.u                                        #Sab  
a<-s-sr.hat[1:n]
b<-r-sr.hat[n+(1:n)]
if( directed==T ) {Sab<-rSab.gibbs(a,b,Sab0,v0)}
if( directed==F ) { s2a<-1/rgamma( 1, pi.s2a[1]+n/2 , pi.s2a[2]+sum(a^2)/2 ) }

#dyad specific regression coef and unit level effects
mu<-c(pim.bd, X.u%*%beta.u)    #"prior" mean for (beta.d,s,r)
if(directed==T){
beta.d.sr<-rbeta.d.sr.gibbs(u,v,su,sv,piS.bd,mu,Sab) 
beta.d<-beta.d.sr$beta.d ; s<-beta.d.sr$s ; r<-beta.d.sr$r
#regression coef for unit level effects
beta.u<-rbeta.sr.gibbs(s,r,X.u,pim.b0sr,piS.b0sr,Sab)
                }
if(directed==F) {
beta.d.s<-rbeta.d.s.gibbs(u,su,piS.bd,mu,s2a)
beta.d<-beta.d.s$beta.d ; s<-beta.d.s$s
#regression coef for unit level effects
beta.u<-rbeta.s.gibbs(s,X.u,pim.b0s,piS.b0s,s2a)
                 }
###


###bilinear effects
if(k>0){

#update variance
#tmp<-eigen(z%*%t(z))
#z<-tmp$vec[,1:k]%*%sqrt(diag(tmp$val[1:k],nrow=k)) #make cols of z orthogonal  
sz<-1/rgamma(k,pi.s2z[,1]+n/2,pi.s2z[,2]+diag( t(z)%*%z)/2)

#Gibbs for zs, using regression
res<-theta-theta.betaX.d.srE.z(beta.d,Xd,s,s*(1-directed)+r*directed,0*E,0*z) #theta-(beta*x+a+b)
s.ares<-se*(1+rho)/2
for(i in sample(1:n))      {
ares<-(res[i,-i]+res[-i,i])/2
Zi<-z[-i,]
Szi<-chol2inv(chol(diag(1/(sz),nrow=k) + 
     t(Zi)%*%Zi/s.ares)) #cond variance of z[i,]
muzi<-Szi%*%( t(Zi)%*%ares/s.ares )                      #cond mean of z[i,]
z[i,]<-t(rmvnorm(muzi,Szi)) }
         }
###
if(k==0){sz<-NULL }

#update E
if( fam!="gaussian"){
E<-theta-theta.betaX.d.srE.z(beta.d,Xd,s,s*(1-directed)+r*directed,E*0,z) 
      #current E|beta.d,Xd,s,r,z

UU<-VV<-Y*0

u<-rnorm(n*(n-1)/2,0,sqrt(su))
v<-rnorm(n*(n-1)/2,0,sqrt(sv))

UU[!is.na(UT)]<-u
tmp<-t(UU)
tmp[!is.na(UT)]<-u
UU<-t(tmp)

VV[!is.na(UT)]<-v
tmp<-t(VV)
tmp[!is.na(UT)]<--v
VV<-t(tmp)

Ep<-(UU+VV)/2
theta.p<-theta-E+Ep

diag(theta.p)<-diag(theta)<-NA



##cases
if(fam=="poisson") { mup<-exp(theta.p) ;  mu<-exp(theta)
                     M.lhr<-dpois(Y,mup,log=T) - dpois(Y,mu,log=T)   }

if(fam=="binomial"){ mup<-exp(theta.p)/(1+exp(theta.p))
                          mu<-exp(theta)/(1+exp(theta))
         M.lhr<-dbinom(Y,N,mup,log=T) - dbinom(Y,N,mu,log=T)   }

   M.lhr[ is.na(M.lhr) ]<-0
   M.lhr<-(M.lhr+t(M.lhr))/( 2^(1-directed) )
   RU<-matrix(log(runif(n*n)),nrow=n,ncol=n)
   RU[is.na(UT)]<-0  ; RU<-RU+t(RU)
   E[M.lhr>RU]<-Ep[M.lhr>RU]
                 }




####output
if(ns%%odens==0){

#compute loglikelihoods of interest
if(fam=="poisson") { lpy.th<-sum( dpois(Y,exp(theta),log=T),na.rm=T) }
if(fam=="binomial"){ lpy.th<-sum( dbinom(Y,N,exp(theta)/(1+exp(theta)),
                                    log=T),na.rm=T) }

if(fam=="gaussian"){ 
E<-theta-theta.betaX.d.srE.z(beta.d,Xd,s,s*(1-directed)+r*directed,E*0,z)
tmp<-uv.E(theta-z%*%t(z)) #the regression part
u<-tmp$u                  #u=yij+yji,  i<j
v<-tmp$v                  #v=yij-yji,  i<j
if(directed==T) {
lpy.th<-sum(dnorm(u,0,sqrt(su),log=T) + dnorm(v,0,sqrt(sv),log=T)) }
if(directed==F) { lpy.th<-2*sum(dnorm(u,0,sqrt(su),log=T))  }
                    }
if(directed==F) {lpy.th<-lpy.th/2
                 out<-round(c(k,ns,lpy.th,beta.d,beta.u,s2a,se,sz[0:k]),oround) }
if(directed==T) {
out<-round(c(k,ns,lpy.th,beta.d,beta.u,Sab[1,1],Sab[1,2],Sab[2,2],
             se,rho,sz[0:k]),oround) }

if(owrite==T) { 
    if(ns==odens) { write.table(t(out),file=ofilename,quote=F,
                     row.names=F,col.names=cnames) }
    if(ns>odens)  { write.table(t(out),file=ofilename,append=T,quote=F,
                    row.names=F,col.names=F) }
              }
if(owrite==F) {cat(out,"\n") }
if(zwrite==T) { write.table(signif(z,sdigz),file=zfilename,
                      append=T*(ns>odens),quote=F,row.names=F,col.names=F) }


if(awrite==T){write.table(round(t(a),oround),file=afilename,append=T*(ns>odens),quote=F,
                    row.names=F,col.names=F)  }
if(bwrite==T & directed==T){write.table(round(t(b),oround),
                    file=bfilename,append=T*(ns>odens),quote=F,
                    row.names=F,col.names=F) }

                 }

}}

#####################End of main function : below are helper functions

####
TuTv<-function(n){
Xu<-Xv<-NULL
for(i in 1:(n-1)){
tmp<-tmp<-NULL
if( i >1 ){ for(j in 1:(i-1)){ tmp<-cbind(tmp,rep(0,n-i)) } }
tmp<-cbind(tmp,rep(1,n-i)) 
tmpu<-cbind(tmp,diag(1,n-i)) ; tmpv<-cbind(tmp,-diag(1,n-i))
Xu<-rbind(Xu,tmpu) ; Xv<-rbind(Xv,tmpv)
         }

list(Tu=cbind(Xu,Xu),Tv=cbind(Xv,-Xv))
                   }
####

XuXv<-function(X){
Xu<-Xv<-NULL
if(dim(X)[3]>0){
for(r in 1:dim(X)[3]){
xu<-xv<-NULL
for(i in 1:(n-1)){
for(j in (i+1):n){ xu<-c(xu,X[i,j,r]+X[j,i,r])
                   xv<-c(xv,X[i,j,r]-X[j,i,r]) }}
Xu<-cbind(Xu,xu)
Xv<-cbind(Xv,xv)  } 
                }
list(Xu=Xu,Xv=Xv)}

###
uv.E<-function(E){
u<- c(  t( (  E + t(E) )  *UT ) )
u<-u[!is.na(u)]

v<-c(  t( (  E - t(E) )  *UT ) )
v<-v[!is.na(v)]
list(u=u,v=v)}
####



####
theta.betaX.d.srE.z<-function(beta.d,X.d,s,r,E,z){
m<-dim(X.d)[3]
mu<-matrix(0,nrow=length(s),ncol=length(s))
if(m>0){for(l in 1:m){ mu<-mu+beta.d[l]*X.d[,,l] }}
tmp<-mu+re(s,r,E,z)
diag(tmp)<-0
tmp}
####

####
re<-function(a,b,E,z){
n<-length(a)
matrix(a,nrow=n,ncol=n,byrow=F)+matrix(b,nrow=n,ncol=n,byrow=T)+E+z%*%t(z) }
####

####
rbeta.d.sr.gibbs<-function(u,v,su,sv,piS.bd,mu,Sab){
del<-Sab[1,1]*Sab[2,2]-Sab[1,2]^2
iSab<-rbind(cbind( diag(rep(1,n))*Sab[2,2]/del ,-diag(rep(1,n))*Sab[1,2]/del),
          cbind( -diag(rep(1,n))*Sab[1,2]/del,diag(rep(1,n))*Sab[1,1]/del) )
rd<-dim(as.matrix(piS.bd))[1]

if(dim(piS.bd)[1]>0){
cov.beta.sr<-matrix(0,nrow=rd,ncol=2*n)
iS<-rbind(cbind(solve(piS.bd),cov.beta.sr),
   cbind(t(cov.beta.sr),iSab)) }
else{iS<-iSab}

Sig<-chol2inv( chol(iS + tXTuXTu/su + tXTvXTv/sv ) )
    #this may have a closed form expression

#theta<-Sig%*%( (t(XTu)%*%u)/su + (t(XTv)%*%v)/sv + iS%*%mu)
theta<-Sig%*%( t(  (u%*%XTu)/su + (v%*%XTv)/sv ) + iS%*%mu)

beta.sr<-rmvnorm(theta,Sig)
list(beta.d=beta.sr[(rd>0):rd],s=beta.sr[rd+1:n],r=beta.sr[rd+n+1:n]) }
####


####
rse.beta.d.gibbs<-function(g0,g1,x,XTx,s,r,beta.d){
n<-length(s)
1/rgamma(1, g0+choose(n,2)/2,g1+.5*sum( (x-XTx%*%c(beta.d,s,r))^2 ) ) }
####


####
rbeta.sr.gibbs<-function(s,r,X.u,pim.b0sr,piS.b0sr,Sab) {
del<-Sab[1,1]*Sab[2,2]-Sab[1,2]^2
iSab<-rbind(cbind( diag(rep(1,n))*Sab[2,2]/del ,-diag(rep(1,n))*Sab[1,2]/del),
          cbind( -diag(rep(1,n))*Sab[1,2]/del,diag(rep(1,n))*Sab[1,1]/del) )

S<-solve( solve(piS.b0sr) + t(X.u)%*%iSab%*%X.u )
mu<-S%*%(  solve(piS.b0sr)%*%pim.b0sr+ t(X.u)%*%iSab%*%c(s,r))
rmvnorm( mu,S)
                                               }
####

####
rSab.gibbs<-function(a,b,S0,v0){
n<-length(a)
ab<-cbind(a,b)
Sn<-S0+ (t(ab)%*%ab)
solve(rwish(solve(Sn),v0+n) )
                               }

####
rmvnorm<-function(mu,Sig2){
R<-t(chol(Sig2))
R%*%(rnorm(length(mu),0,1)) +mu }


####
rwish<-function(S0,nu){ 
S<-S0*0
for(i in 1:nu){ z<-rmvnorm(rep(0,dim(as.matrix(S0))[1]), S0)
                S<-S+z%*%t(z)  }
		S }

###  Procrustes transformation: rotation and reflection
proc.rr<-function(Y,X){
k<-dim(X)[2]
A<-t(Y)%*%(  X%*%t(X)  )%*%Y
eA<-eigen(A,symmetric=T)
Ahalf<-eA$vec[,1:k]%*%diag(sqrt(eA$val[1:k]),nrow=k)%*%t(eA$vec[,1:k])
                                                                                  
t(t(X)%*%Y%*%solve(Ahalf)%*%t(Y)) }
###



gbme.glmstart<-function(Y,Xd,Xs,Xr,N=NULL,fam,k,directed){  
#generate starting values and emp bayes priors from 
#approximate mles

if(fam!="binomial"){
y<-x<-NULL
for (i in 1:n) {
for (j in (1:n)[-i]) {
y<-c(y,Y[i,j])
x<-rbind(x,c(i,j,Xd[i,j,])) }}
                    }

if(fam=="binomial"){
y<-x<-NULL
for (i in 1:n) {
for (j in (1:n)[-i]) {
y<-rbind(y,c(Y[i,j], N[i,j]-Y[i,j] ))
x<-rbind(x,c(i,j,Xd[i,j,])) }}
                    }


if(rd>0) {
 fit1<-glm(y~-1+as.factor(x[,1])+as.factor(x[,2])+x[,-(1:2)],family=fam) }
if(rd==0){ fit1<-glm(y~-1+as.factor(x[,1])+as.factor(x[,2]),family=fam) }
                                                                                  
s<-fit1$coef[1:n]
r<-c(0,fit1$coef[n+1:(n-1)])
if(rd>0){
beta.d<-fit1$coef[(2*n):length(fit1$coef)]               #beta.d
        }
                                                                                  
la<-lm( s~-1+cbind(rep(.5,n),Xs)); a<-la$res
lb<-lm( r~-1+cbind(rep(.5,n),Xr)); b<-lb$res
                                                                                  
b0<-(la$coef[1]+lb$coef[1])/2
                                                                                  
s1<-s+( b0-la$coef[1])/2                 #s
r1<-r+( b0-lb$coef[1])/2                 #r
                                                                                  
la<-lm( s1~-1+cbind(rep(.5,n),Xs)); a<-la$res
lb<-lm( r1~-1+cbind(rep(.5,n),Xr)); b<-lb$res
                                                                                  
beta.u<-c(lb$coef[1], la$coef[-1],lb$coef[-1])
Sab<-var(cbind(a,b))                    #Sab

Res<-matrix(0,nrow=n,ncol=n)
l<-1 
for( m in 1:dim(x)[1] ) {
if( !is.na(y[m]) ) { Res[x[m,1],x[m,2]]<-fit1$res[l] ; l<-l+1 }
                         }
######
Res[Res>quantile(Res,.95,na.rm=T) ] <- quantile(Res,.95,na.rm=T)
diag(Res)<-rep(0,n)
                                                                                  
if(k>0){
for(i in 1:50){
tmp<-eigen( .5*(Res+t(Res) ))
z<-tmp$vec[,1:k] %*%diag(sqrt(tmp$val[1:k]),nrow=k)
diag(Res)<-diag(z%*%t(z))
                 }
sz<-var(c(z))                         #z,sz
E<-Res-z%*%t(z)                           #E
          }
if(k==0){E<-Res ; z<-matrix(0,nrow=n,ncol=1) ;sz<-.1}

u<-E+t(E)
u<-c(u[!is.na(UT)])                      #su
su<-var(u)                               #sv
v<-E-t(E)
v<-c(v[!is.na(UT)])
sv<-var(v)
                                                                                  
rho<-(su-sv)/(su+sv)
se<-(su+sv)/4


###construct priors centered on these empirical values
pi.Sab<-c(Sab[1,1],Sab[2,1],Sab[2,2],4)
pi.s2u<-c(2,su)
pi.s2v<-c(2,sv)
pi.s2z<-cbind( rep(2,k), diag( t(z)%*%z)/n )
                                                                                  
if(rd>0){
pim.bd<-c(beta.d)
piS.bd<-as.matrix((n*(n-1))^2*summary(fit1)$cov.unscaled[(2*n):length(fit1$coef),
                                          (2*n):length(fit1$coef)] )
         }
                                                                                  
                                                                                  
if(rd==0){ beta.d<-pim.bd<-NULL ;  piS.bd<-matrix(nrow=0,ncol=0) }
                                                                                  
if(directed==T) {
pim.b0sr<-beta.u
piS.b0sr<-rbind(cbind( summary(la)$cov[-1,-1], matrix(0,nrow=rs,ncol=rr)),
# cbind(matrix(0,nrow=rs,ncol=rr),summary(lb)$cov[-1,-1]))
# error found 7-7-6
  cbind(matrix(0,nrow=rr,ncol=rs),summary(lb)$cov[-1,-1]))

piS.b0sr<-rbind(c(summary(la)$cov[1,-1],summary(lb)$cov[1,-1]),piS.b0sr)
piS.b0sr<-cbind(c(summary(la)$cov[1,1:(rs+1)],
                  summary(lb)$cov[1,-1]),piS.b0sr)
piS.b0sr<-as.matrix(piS.b0sr*n*n) 

pim.b0s<-NULL ; piS.b0s<-NULL  ;pi.s2a<-NULL
                }
if(directed==F) { pim.b0sr<-NULL ; piS.b0sr<-NULL ; pi.Sab<-NULL
                  s<-(s+r)/2  ; r<-s*0
                  tmp2<-lm(s~-1+cbind( rep(.5,n),Xs)) 
                  beta.u<-tmp2$coef ; pi.s2a<-c(2,var(tmp2$res)) ;
                  pim.b0s<-tmp2$coef ; piS.b0s<-summary(tmp2)$cov*n*n }



###
list( priors=list(pi.Sab=pi.Sab,pi.s2u=pi.s2u,pi.s2v=pi.s2v,pi.s2z=pi.s2z,
                  pim.bd=pim.bd,piS.bd=piS.bd,
                  pim.b0sr=pim.b0sr,piS.b0sr=piS.b0sr,
                  pim.b0s=pim.b0s, piS.b0s=piS.b0s , pi.s2a=pi.s2a) ,
      startv=list(beta.d=beta.d,beta.u=beta.u,s=s,r=r,z=z)
     )
}


####
rbeta.d.s.gibbs<-function(u,su,piS.bd,mu,s2a){
iSa<-diag(rep(1/s2a,n))

if(dim(piS.bd)[1]>0){
cov.beta.s<-matrix(0,nrow=rd,ncol=n)
iS<-rbind(cbind(solve(piS.bd),cov.beta.s),
   cbind(t(cov.beta.s),iSa)) }
else{iS<-iSa}

Sig<-chol2inv( chol(iS + tXTuXTu/su ) )
    #this may have a closed form expression

theta<-Sig%*%( t(  (u%*%XTu)/su) + iS%*%mu)

beta.s<-rmvnorm(theta,Sig)
list(beta.d=beta.s[(rd>0):rd],s=beta.s[rd+1:n]) }
####

####
rbeta.s.gibbs<-function(s,X.u,pim.b0s,piS.b0s,s2a) {
iSa<-diag(rep(1/s2a,n))

S<-solve( solve(piS.b0s) + t(X.u)%*%iSa%*%X.u )
mu<-S%*%(  solve(piS.b0s)%*%pim.b0s+ t(X.u)%*%iSa%*%s)
rmvnorm( mu,S)
                                               }


