## import data

#install.packages("openxlsx")
library(openxlsx)
meta <- read.xlsx("./Edit data/samples_metadata.xlsx", startRow = 1, sheet=1, colNames=TRUE)
data <- read.csv("./Edit data/no_hypothetical_analysis2.csv", header = TRUE )

#transpose data set and merge in the interested field: country
n <- data$Gene_Product

data_t <- as.data.frame(t(data[, -1]))
colnames(data_t) <- n
data_t$sample_id <- factor(substr(row.names(data_t), 1, nchar(row.names(data_t))-2))


temp <-  meta[, c("ncbi_sra", "country")]
country <- merge(data_t, temp, by.x = "sample_id", by.y= "ncbi_sra", all.x = TRUE)


colnames(data_t) <- n
data_t$sample_id <- factor(row.names(data_t))
rm(data_t)

