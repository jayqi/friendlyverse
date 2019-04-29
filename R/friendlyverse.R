# Package article (?friendlyverse-package)
# Copies DESCRIPTION file if no content explicitly provided
#' @keywords internal
"_PACKAGE"

#' @title List friendlyverse packages
#' @description List all friendlyverse packages.
#' @return character vector
#' @export
friendlyverse_packages <- function() {
    raw <- utils::packageDescription("friendlyverse")[['Imports']]
    imports <- unlist(strsplit(raw, split = "\\s*,\\s*"))
    return(imports)
}

# Return already loaded friendlyverse packages
friendlyverse_loaded <- function() {
    friendlyverse_packages()[friendlyverse_packages() %in% .packages()]
}

# Return not yet loaded friendly verse packages
friendlyverse_unloaded <- function() {
    friendlyverse_packages()[!friendlyverse_packages() %in% .packages()]
}

# Load friendlyverse packages
friendlyverse_attach <- function() {
    to_load <- friendlyverse_unloaded()
    if (length(to_load) == 0) {
        return(invisible(NULL))
    }
    cat(sprintf('Attaching packages: %s', paste(to_load, collapse = ", ")))
    lapply(to_load, library, character.only = TRUE)
    return(invisible(NULL))
}

#' @title Reinstall friendlyverse packages
#' @description Reinstall all friendlyverse packages from CRAN.
#' @return NULL invisibly
#' @export
friendlyverse_reinstall <- function() {
    pkgs <- c(friendlyverse_packages(), "friendlyverse")
    install.packages(pkgs)
    return(invisible(NULL))
}

### KEEP AT BOTTOM ###
# Load friendlyverse packages upon loading friendlyverse itself
.onAttach <- function(...) {
    friendlyverse_attach()
}
### KEEP AT BOTTOM ###
