#------------
# Function for adding trunc print output adding ellipsis
#------------

require(knitr)

# save the built-in output hook
hook_output <- knit_hooks$get("output")

# set a new output hook to truncate text output
knit_hooks$set(output = function(x, options) {
  if (!is.null(n <- options$out.lines)) {
    x <- xfun::split_lines(x)

    if (n < 0) {
      x <- c("....\n", tail(x, abs(n)))    # truncate the output
    } else {
      x <- c(head(x, n), "....\n")
    }
    x <- paste(x, collapse = "\n")
  }
  hook_output(x, options)
})