The following code block works on R v4.4.3.
On R v4.5.2 it succeeds with cores = 1 but fails with cores = 2, raising the following error:

Error in manager$availability[[as.character(result$node)]] <- TRUE :
  wrong args for environment subassignment

Error in serialize(data, node$con, xdr = FALSE) :
  error writing to connection

The entire project is available at:
https://github.com/carmelo-catalano/dream_issue
```R
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

```
