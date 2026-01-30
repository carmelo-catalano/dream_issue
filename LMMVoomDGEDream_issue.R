library("variancePartition")
library("edgeR")

rna_seq <- readRDS("als_NYGC_rna_seq.Rds")
formula <- ~tissue_status + (1 | tissue)
cores <- 2

dge_list <- DGEList(rna_seq$data, remove.zeros = TRUE)
dge_list <- calcNormFactors(dge_list, method = 'upperquartile')
parallelComputationParam <- SnowParam(cores, "FORK", progressbar = TRUE)
voom_data <- voomWithDreamWeights(dge_list, formula, rna_seq$metadata, BPPARAM = parallelComputationParam)
dream_result <- dream(voom_data, formula, rna_seq$metadata, BPPARAM = parallelComputationParam)

print("computation completed successfully")

