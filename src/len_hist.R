library(ggplot2)

experiments <- c('ENCFF443MVY', 'ENCFF926NKP')
assembly <- c('hg38', 'hg19')

for (exp in experiments) {
    for (ass in assembly) {
        name <- paste('H3K27ac_A549', exp, ass, sep = '.')
        fname <- paste0('data/', name, '.bed')

        bed_df <- read.delim(fname, as.is = TRUE, header = FALSE)
        colnames(bed_df) <- c('chrom', 'start', 'end')
        bed_df$len <- bed_df$end - bed_df$start

        subtitle <- sprintf('Number of peaks = %s', nrow(bed_df))
        pname <- paste('len_hist', name, 'pdf', sep = '.')

        ggplot(bed_df) + aes(x = len) + geom_histogram() +
            ggtitle(name, subtitle = subtitle) + theme_bw()
        ggsave(pname, path = 'img')
    }
}
