#' For a vector of postal codes, identify
#' those which are in low income communities
#'
#' @param postal_code
#' A vector of postal codes
#' @param lim_at_prevalence_threshold
#' The lowest prevalence of LIM-AT that would categorize a community as low income,
#' Defaults to 19.3%, the lower bound of the 4th quartile of LIM-AT prevalence among FSAs.
#' @param format
#' The format of the return vector. Either "label" (the default), or "indicator".
#' If the format is "label", the returned vector will be a factor with verbose category labels.
#' If the format is "indicator", the returned vector will be a numeric boolean (1, 0, or NA)
#'
#' @return
#' A vector of low income assessments for each value in postal_code, in the specified format
#' @export
#'
#' @examples
clc_calculate_low_income <- function(postal_code, lim_at_prevalence_threshold = 0.193, format = c("label", "indicator")) {

  dat <-

    tibble::tibble(
      postal_code = postal_code
    ) %>%

    dplyr::mutate(
      fsa = stringr::str_sub(postal_code, 1L, 3L)
    ) %>%

    dplyr::left_join(fsa_data, by = "fsa") %>%

    dplyr::mutate(
      low_income = switch(
        format[1],

        "label" = dplyr::case_when(
            lim_at_prevalence >= lim_at_prevalence_threshold ~ as.character(glue::glue("Low Income (LIM-AT prev. \U2265 {scales::percent(lim_at_prevalence_threshold, accuracy = 0.1)})")),
            lim_at_prevalence < lim_at_prevalence_threshold  ~ as.character(glue::glue("Not Low Income (LIM-AT prev. \U003C {scales::percent(lim_at_prevalence_threshold, accuracy = 0.1)})")),
            TRUE ~ NA_character_
          ) %>%

            fct_explicit_na(),

        "indicator" = as.numeric(lim_at_prevalence >= lim_at_prevalence_threshold)
      )
    )

  dat$low_income

}

#' For a vector of postal codes, identify which ones are in
#' rural communities
#'
#' @param postal_code
#' A vector of postal codes
#' @param sac_index_threshold
#' The lowest SAC index that should be classified as rural. Defaults to 4 (moderate metropolitan influence zone)
#' @param format
#' The format of the return vector. Either "label" (the default), or "indicator".
#' If the format is "label", the returned vector will be a factor with verbose category labels.
#' If the format is "indicator", the returned vector will be a numeric boolean (1, 0, or NA)
#'
#' @return
#' @export
#'
#' @examples
clc_calculate_rural <- function(postal_code, sac_index_threshold = 4, format = "label") {

  dat <-

    tibble::tibble(
      postal_code = postal_code
    ) %>%

    dplyr::mutate(
      fsa = stringr::str_sub(postal_code, 1L, 3L)
    ) %>%

    dplyr::left_join(fsa_data, by = "fsa") %>%

    dplyr::mutate(
      low_income =

        dplyr::case_when(
          sac_rural_category >= sac_index_threshold ~ as.character(glue::glue("Rural (SAC \U2265 {sac_index_threshold})")),
          sac_rural_category  < sac_index_threshold ~ as.character(glue::glue("Not Rural (SAC \U003C {sac_index_threshold})")),
          TRUE ~ NA_character_
        ) %>%

        fct_explicit_na()
    )

  dat$low_income
}

#' Get a table of community data about a vector of postal codes
#'
#' @param postal_code
#'
#' @return
#' @export
#'
#' @examples
add_community_data <- function(dat, postal_code_colname = NULL) {

  .postal_code_colname <- rlang::enquo(postal_code_colname)

  if(rlang::quo_is_null(.postal_code_colname)) {
    .postal_code_colname <- rlang::quo(postal_code)
  }

  overlapping_colnames <- base::intersect(colnames(dat), colnames(fsa_data))


  res <-

    dat %>%

    dplyr::mutate(
      fsa = stringr::str_sub(!!.postal_code_colname, 1L, 3L)
    ) %>%

    dplyr::left_join(dplyr::select(fsa_data, -dplyr::all_of(overlapping_colnames)), by = "fsa")

  res

}

