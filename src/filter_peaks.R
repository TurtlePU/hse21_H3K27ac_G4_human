library(dplyr)
library(ggplot2)

for (exp in c('ENCFF443MVY', 'ENCFF926NKP')) {
    name <- paste('H3K27ac_A549', exp, 'hg19', sep='.')
    fname <- paste0('data/', name, '.bed')

    bed_df <- read.delim(fname, as.is = TRUE, header = FALSE)
    colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
    bed_df$len <- bed_df$end - bed_df$start
    head(bed_df)

    subtitle <- sprintf('Number of peaks = %s', nrow(bed_df))
    ggplot(bed_df) + aes(x = len) + geom_histogram() +
        ggtitle(name, subtitle = subtitle) + theme_bw()
    ggsave(paste0('filter_peaks.', name, '.init.hist.pdf'), path = 'img')

    bed_df <- bed_df %>% arrange(-len) %>% filter(len < 10000)

    subtitle <- sprintf('Number of peaks = %s', nrow(bed_df))
    ggplot(bed_df) + aes(x = len) + geom_histogram() +
        ggtitle(name, subtitle = subtitle) + theme_bw()
    ggsave(paste0('filter_peaks.', name, '.filtered.hist.pdf'), path = 'img')

    file = paste0('data/', name, '.filtered.bed')
    bed_df %>% select(-len) %>% write.table(
        file = file, col.names = FALSE, row.names = FALSE, sep = '\t',
        quote = FALSE)
}
