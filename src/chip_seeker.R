library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(clusterProfiler)

for (exp in c('ENCFF443MVY', 'ENCFF926NKP')) {
    name <- paste0('H3K27ac_A549.', exp, '.hg19.filtered')
    fname <- paste0('data/', name, '.bed')
    peakAnno <- annotatePeak(fname, tssRegion=c(-3000, 3000),
        TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene, annoDb="org.Hs.eg.db")
    png(paste0('img/chip_seeker.', name, '.plotAnnoPie.png'))
    plotAnnoPie(peakAnno)
    dev.off()
}
