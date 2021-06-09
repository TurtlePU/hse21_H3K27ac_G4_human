library(ggplot2)
library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(clusterProfiler)

name <- 'G4_chip'
fname <- 'data/G4_chip.bed'

bed_df <- read.delim(fname, as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start

subtitle <- sprintf('Number of peaks = %s', nrow(bed_df))
pname <- paste('len_hist', name, 'pdf', sep = '.')

ggplot(bed_df) + aes(x = len) + geom_histogram() +
    ggtitle(name, subtitle = subtitle) + theme_bw()
ggsave(pname, path = 'img')

peakAnno <- annotatePeak(fname, tssRegion=c(-3000, 3000),
    TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene, annoDb="org.Hs.eg.db")
png(paste0('img/chip_seeker.', name, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()
