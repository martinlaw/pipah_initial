library(clinfun)
ph2simon(pu = 0.1, pa = 0.27, ep1 = 0.05, ep2 = 0.2)
devtools::install_github("martinlaw/SCsinglearm")
library(SCsinglearm)

 system.time({
  simon.des <- findSimonDesigns(nmin=34,
                      nmax=35,
                      p0=0.1,
                      p1=0.27,
                      alpha=0.05,
                      power=0.8,
                      benefit=FALSE)
}) 
drawDiagram(simon.des)

system.time({
  simon.des.eff <- findSimonDesigns(nmin=20,
                                nmax=40,
                                p0=0.1,
                                p1=0.27,
                                alpha=0.05,
                                power=0.8,
                                benefit=TRUE)
}) # 30mins!!

system.time({
  SCdesigns1 <- findDesigns(nmin=17,
              nmax=36,
              stages=2:3,
              p0=0.1,
              p1=0.27,
              alpha=0.05,
              power=0.8,
              maxthetaF=1,
              minthetaE=1,
              bounds="wald",
              return.only.admissible=TRUE)
})
drawDiagram(SCdesigns1)
#save.image("pipah_SS_calcs_25nov2020.RData")


system.time({
  SCdesigns.wider <- findDesigns(nmin=16,
                           nmax=50,
                           C=1,
                           p0=0.1,
                           p1=0.27,
                           alpha=0.05,
                           power=0.8,
                           maxtheta0=0.05,
                           mintheta1=0.95,
                           bounds="wald",
                           return.only.admissible=TRUE)
})


system.time({
  SC.type.designs <- SCfn(nmin=43,
                                 nmax=43,
                                 p0=0.1,
                                 p=0.27,
                                 alpha=0.05,
                                 power=0.8,
                                 maxtheta0=0.05,
                                 mintheta1=0.95,
                                 bounds="wald",
                                 maxthetas = 1e2)
  })

library(doParallel)
detectCores()
cl <- makeCluster(30)
registerDoParallel(cl)
getDoParWorkers()

nrange <- 16:43
timed <- system.time({
  pipah.sc <- foreach(i=nrange) %dopar% {
    SCfn(nmin=i,
         nmax=i,   
         p0=0.1,
         p=0.27,
         alpha=0.05,
         power=0.8,
         maxtheta0=0.05,
         mintheta1=0.95,
         bounds="wald",
         maxthetas = 1e2
        )
  }
}) # 1e2:
# Collapse list and remove NA rows:
sc.results.df <- do.call(rbind, pipah.sc)
sc.results.df <- sc.results.df[apply(sc.results.df, 1, function(x) !all(is.na(x))),]
# Remove all non-admissible designs:
discard <- rep(NA, nrow(sc.results.df))
for(i in 1:nrow(sc.results.df)){
  discard[i] <- sum(sc.results.df$EssH0[i] > sc.results.df$EssH0 & sc.results.df$Ess[i] > sc.results.df$Ess & sc.results.df$n[i] >= sc.results.df$n)
}
sc.final <- sc.results.df[discard==0,]


# CP at point (S=1, m=13) in Simon design:
# Success if 7 or more responses at N=34, so success if 6 or more success in remaining 21 participants:
p <- 0.27
q <- 1-p
i <- 6:21
sum(choose(21,i) * p^i*q^(21-i))
# CP at (S=1, m=13) is 0.52