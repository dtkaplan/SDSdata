#' Medical info on 100,000 randomly sampled births in the US in 2014
#'
#' The Centers for Disease Control collects data on all births registered
#' in the US (50 states + DC). The
#' full data set is provided by the `natality2014` package.
#' `Births_2014` is a simplified version of `natality_2014::Natality_2014_100k`
#' with some variables renamed for simplicity and some numerical variables converted
#' to categorical.
#'
#' @docType data
#' @name Births_2014
#'
#' @keywords datasets
#'
#' @format
#'   A data frame with a random sample of size 100000 from the complete CDC set of 3,998,175 cases, each of which is a birth in the US in 2014.
#'   \itemize{
#'     \item{\code{age_mother}} {Mother's age at date of birth}
#'     \item{\code{age_father}} {Father's age at date of birth}
#'     \item{\code{induced}} {Was labor induced?}
#'     \item{\code{ventilator}} {Baby put on mechanical ventilator immediately}
#'     \item{\code{baby_wt}} {Baby's weight (gm)}
#'     \item{\code{gestation}} {Length of gestation}
#'     \item{\code{sex}} {Baby's sex}
#'     \item{\code{plurality}} {Plurality of birth: 2 = twins, 3 = triplets, ...}
#'     \item{\code{apgar5}} {APGAR score at 5 minutes}
#'     \item{\code{pay}} {Source of payment for delivery}
#'     \item{\code{delivery}} {Method of delivery}
#'     \item{\code{induced}} {Labor induced}
#'     \item{\code{mother_wt_before}} {Mother's weight before pregnancy}
#'     \item{\code{mother_wt_delivery}} {Mother's weight at delivery}
#'     \item{\code{mother_height}} {Mother's height}
#'     \item{\code{cig_0}} {Number of cigarettes smoked daily before pregnancy}
#'     \item{\code{cig_1}} {Number of cigarettes smoked daily during first trimester}
#'     \item{\code{cig_2}} {Number of cigarettes smoked daily during second trimester}
#'     \item{\code{cig_3}} {Number of cigarettes smoked daily during third trimester}
#'     \item{\code{wic}} {Enrolled in Women, Infants, and Children (WIC) program for supplemental nutrition.}
#'     \item{\code{month_start_prenatal}} {Month started in prenatal care. 15 means never started.}
#'     \item{\code{prenatal_visits}} {Number of visits to prenatal care.}
#'
#'   }
#'
#' @seealso \code{\link{Larger_natality_data_files}}
#'
"Births_2014"
