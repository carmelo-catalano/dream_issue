The following code block works on R v4.4.3.
On R v4.5.2 it succeeds with cores = 1 but fails with cores = 2, raising the following error:

Error in manager$availability[[as.character(result$node)]] <- TRUE :
  wrong args for environment subassignment

Error in serialize(data, node$con, xdr = FALSE) :
  error writing to connection

```{r}
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

Type any R code in the chunk, for example:
```{r}
mycars <- within(mtcars, { cyl <- ordered(cyl) })
mycars
```

Now, click the **Run** button on the chunk toolbar to [execute](https://www.jetbrains.com/help/pycharm/r-markdown.html#run-r-code) the chunk code. The result should be placed under the chunk.
Click the **Knit and Open Document** to build and preview an output.
