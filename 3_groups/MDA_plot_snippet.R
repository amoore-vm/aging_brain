#The following is a code snippet for the Mouse Development & Aging project that 
#allows samples requiring displays at 3 different point sizes to be plotted simultaneously. 




#rename the p21 samples
merge.obj$orig.ident <- dplyr::recode(merge.obj$orig.ident,
                                      "mf_p21_rep1" = "p21_1",
                                      "mf_p21_rep2" = "p21_2")

#As the 3 different groups require 3 different point sizes, let's generate 3 images simultaneously, each with the most appropriate point size for its group.
adult_subset <- subset(merge.obj, subset = orig.ident %in% c("adult_1", "adult_2"))
p21_subset <- subset(merge.obj, subset = orig.ident %in% c("p21_1", "p21_2"))
aged_subset <- subset(merge.obj, subset = orig.ident %in% c("aged_1", "aged_2"))

#Test ability to generate accurate figures
adult_img<-SpatialFeaturePlot(adult_subset, features = "Cst3", keep.scale="feature", 
                              min.cutoff = "q05",    #quantiles
                              max.cutoff = "q95",
                              pt.size.factor = 2)
ggsave("./Figures/Spatial_Gene/cst3_adult.png", height = 5, width = 9, unit = 'in') #adult size = 2

p21_img<-SpatialFeaturePlot(p21_subset, features = "Cst3", keep.scale="feature", 
                            min.cutoff = "q05",    #quantiles
                            max.cutoff = "q95",
                            pt.size.factor = 475)
ggsave("./Figures/Spatial_Gene/cst3_p21.png", height = 5, width = 9, unit = 'in') #p21 size = 475

aged_img<-SpatialFeaturePlot(aged_subset, features = "Cst3", keep.scale="feature", 
                             min.cutoff = 7,    #quantiles
                             max.cutoff = 8.5,
                             pt.size.factor = 3)
ggsave("./Figures/Spatial_Gene/cst3_aged.png", height = 5, width = 9, unit = 'in') #aged size = 3

#uses patchwork, a Seurat function
combined_img <- (p21_img | adult_img | aged_img) + plot_layout(ncol = 1, nrow = 3) 
ggsave("./Figures/Spatial_Gene/cst3_combined.png", height = 12, width = 6, unit = 'in') 
#ncol = 1 b/c each image (containing 2 samples) is a single image; need to define both ncol & nrow or won't run.
print(combined_img)
#The above workflow will generate a single image with all 3 samples with points plotted each at the appropriate size for the sample. 