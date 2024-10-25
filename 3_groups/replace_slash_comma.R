original_string <- "Tmem163/Pllp/Cldn5"

# Replace forward slashes with ", "
modified_string <- gsub("/", ", ", original_string)

# Split the modified string into individual words
genes <- strsplit(modified_string, ", ")[[1]]

# Count the number of words
gene_count <- length(strsplit(modified_string, ", ")[[1]])

# Insert "and" between the final two words
if (length(genes) > 1) {
  modified_string <- paste(paste(genes[-length(genes)], collapse = ", "), "and", genes[length(genes)])
} else {
  modified_string <- genes  # If there's only one word, no need for "and"
}

# Print the modified string and word count
print(modified_string)
print(paste("Number of genes:", gene_count))