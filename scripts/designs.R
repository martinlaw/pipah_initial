library(curtailment)
# Current Simon design:
simon <- find2stageDesigns(nmin=34,
                              nmax=34,
                              p0=0.1,
                              p1=0.27,
                              alpha=0.05,
                              power=0.8)
simon$all.des[1,]
simon.plot <- drawDiagram(simon, print.row = 1)

NSCdesigns <- findNSCdesigns(nmin=10,
                             nmax=34,
                             p0=0.1,
                             p1=0.27,
                             alpha=0.05,
                             power=0.8)
drawDiagram(NSCdesigns, print.row=1)


# SC design. SC for futility stopping, NSC for efficacy stopping (minthetaE=1):
SCdesigns.certain <- singlearmDesign(nmin=17,
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
sc.certain <- drawDiagram(SCdesigns.certain, print.row = 3, xmax = 33, ymax = 34)

# SC design. SC for futility stopping, SC for efficacy stopping:
SCdesigns <- singlearmDesign(nmin=17,
                         nmax=36,
                         stages=2:3,
                         p0=0.1,
                         p1=0.27,
                         alpha=0.05,
                         power=0.8,
                         maxthetaF=0.52,
                         minthetaE=0.9)
SCdesigns$all.des[3,]
# N=33, ESS0=20, ESS1=21, stages=3
sc3 <- drawDiagram(SCdesigns, print.row = 3, xmax = 34, ymax = 34)


#ggplot2::ggsave(filename="simon.tiff", plot=simon.plot, device="tiff", path="figs/", width = 6, height = 4, units = "in", dpi=300)
#ggplot2::ggsave(filename="SCfutility_NSCefficacy.tiff", plot=sc.certain, device="tiff", path="figs/", width = 6, height = 4, units = "in", dpi=300)
#ggplot2::ggsave(filename="SCfutility_efficacy.tiff", plot=sc3, device="tiff", path="figs/", width = 6, height = 4, units = "in", dpi=300)

