library(curtailment)

# Current Simon design:
simon.des <- findSimonDesigns(nmin=34,
                              nmax=34,
                              p0=0.1,
                              p1=0.27,
                              alpha=0.05,
                              power=0.8)
simon.des$all.des[1,]
simon.used <- drawDiagram(simon.des, print.row = 1)
png("figs/simonX.png", width = 6, height = 4, units = "in", res=300)
simon.used
dev.off()
# N=34, ESS0=21, ESS1=32, stages=2



# Stopping for efficacy allowed only when trial success is certain (minthetaE=1):
SCdesigns.certain <- findDesigns(nmin=17,
                          nmax=36,
                          stages=2:3,
                          p0=0.1,
                          p1=0.27,
                          alpha=0.05,
                          power=0.8,
                          maxthetaF=1,
                          minthetaE=1)
# One design produced that is worth considering:
SCdesigns.certain$all.des[3,]
# N=33, ESS0=22, ESS1=28, stages=3
sc.certain <- drawDiagram(SCdesigns.certain, print.row = 3, xmax = 34, ymax = 34)
png("sc_certain.png", width = 6, height = 4, units = "in", res=300)
sc.certain
dev.off()


# Without constraint of only stopping once trial success guaranteed:
SCdesigns <- curtailment::singlearmDesign(nmin=17,
                         nmax=36,
                         stages=2:3,
                         p0=0.1,
                         p1=0.27,
                         alpha=0.05,
                         power=0.8,
                         maxthetaF=0.52,
                         minthetaE=0.9)
# Three designs produced that are worth considering:
SCdesigns$all.des[1,]
# N=32, ESS0=29, ESS1=28, stages=2
SCdesigns$all.des[2,]
# N=34, ESS0=26, ESS1=28, stages=2
SCdesigns$all.des[3,]
# N=33, ESS0=20, ESS1=21, stages=3

sc1 <- drawDiagram(SCdesigns, print.row = 1, xmax = 34, ymax = 34)
png("sc1.png", width = 6, height = 4, units = "in", res=300)
sc1
dev.off()

sc3 <- drawDiagram(SCdesigns, print.row = 3, xmax = 34, ymax = 34)
png("sc3.png", width = 6, height = 4, units = "in", res=300)
sc3
dev.off()


SCdesigns.9 <- curtailment::singlearmDesign(nmin=17,
                         nmax=36,
                         stages=2:3,
                         p0=0.1,
                         p1=0.27,
                         alpha=0.05,
                         power=0.8,
                         maxthetaF=0.5,
                         minthetaE=0.9)
png("figs/sc3_33.png", width = 6, height = 4, units = "in", res=300)
drawDiagram(SCdesigns.9, print.row=2, ymax=34)
dev.off()
