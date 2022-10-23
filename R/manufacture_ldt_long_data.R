#' Generate long form lexical decision data
#'
#' @returns A rectangular dataset with class tibble
#' @examples
#' dat_long = manufacture_ldt_long_data()
#' str(dat_long)
#' summary(dat_long)
#' require("ggplot2")
#' ggplot(dat_long, aes(x = rt, fill = condition)) +
#'   geom_density(alpha = 0.75)+
#'   scale_x_continuous(name = "Reaction time (ms)")+
#'   scale_fill_discrete(name = "Condition")
#' @export
manufacture_ldt_long_data <- function(){
  rawcsvname <- fs::path_package(package = "beginr", "extdata", "ldt_data.csv")
  dat <- readr::read_csv(file = rawcsvname, show_col_types = FALSE)
  dat <- dplyr::mutate(.data = dat, language=factor(language, levels=c(1,2), labels=c("Monolingual", "Bilingual")))
  dat <- tidyr::pivot_longer(data = dat, cols = c(rt_word, rt_nonword, acc_word, acc_nonword), names_sep = "_", names_to = c("dv_type", "condition"), values_to = "dv")
  dat <- tidyr::pivot_wider(data = dat, names_from = "dv_type", values_from = "dv")
  dat <- dplyr::mutate(.data = dat, condition = factor(condition, levels=c("word", "nonword"), labels=c("Word", "Non-Word")))
  dat <- dplyr::mutate(.data = dat, id = forcats::as_factor(id))
}
