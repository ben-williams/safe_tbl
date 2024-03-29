library(dplyr)
library(flextable)

main_table <- function(data, year, tier){

  flextable(data) %>%
    add_header_row(value = c( "", "a", "b"), colwidths = c(1,2,2)) %>%
    compose(i=2, j=1,
            value = as_paragraph( "Quantity/Status"),
            part = "header") %>%
    compose(i = 1, j = 2:3,
            value = as_paragraph( "As estimated or " , as_i("specified last"), " year for:"),
            part = "header") %>%
    compose(i = 1, j = 4:5,
            value = as_paragraph( "As estimated or " , as_i("recommended this"), " year for:"),
            part = "header") %>%
    compose(i = 2, j = 2, value = as_paragraph(as.character(year)), part = "header") %>%
    compose(i = 2, j = 3:4, value = as_paragraph(as_chunk(as.character(year + 1))),
            part = "header") %>%
    compose(i = 2, j = 5, value = as_paragraph(as_chunk(as.character(year + 2))),
            part = "header") %>%
    align(align = "center", part = "header") %>%
    align(j=2:5, align = "center") %>%
    align(j = 1, part = "header", align="left") %>%
    bold(i = 2, j = 1, part = "header") %>%
    width(j = 1, width = 2.5) %>%
    width(j = 2:5, width = 0.65) %>%
    bg(j = 2, bg = "#f7f7f7", part = "all") %>%
    bg(j = 3, bg = "#f7f7f7", part = "all") %>%
    border_remove() %>%
    hline_top(part = "header") %>%
    hline_top() %>%
    vline_right(part = "body") %>%
    vline_right(part = "header") %>%
    vline_left(part = "body") %>%
    vline_left(part = "header") -> tbl

  if(tier == 3){
    tier = "3a"
    tbl %>%
      footnote(i=2, j=4:5, part = "header", ref_symbols = "*",
               value = as_paragraph(as_chunk(paste0("Projections are based on an estimated catch of ",
                                                    prettyNum(c1, big.mark = ","), " t for ", year,
                                                    " and estimates of ",
                                                    prettyNum(c2, big.mark = ","),
                                                    " t and ",
                                                    prettyNum(c3, big.mark = ","),
                                                    " t used in place of maximum permissible ABC for ",
                                                    year+1, " and ", year+2, "."))),
               sep = ".") %>%
      compose(i = 2, j = 2:5, value = as_paragraph(tier)) %>%
      compose(i = 5, j = 1, value = as_paragraph("B", as_sub("100%"))) %>%
      compose(i = 6, j = 1, value = as_paragraph("B", as_sub("40%"))) %>%
      compose(i = 7, j = 1, value = as_paragraph("B", as_sub("35%"))) %>%
      compose(i = 8, j = 1, value = as_paragraph("F", as_sub("OFL"))) %>%
      compose(i = 9, j = 1, value = as_paragraph(as_i("max"),"F", as_sub("ABC"))) %>%
      compose(i = 10, j = 1, value = as_paragraph("F", as_sub("ABC"))) %>%
      compose(i = 12, j = 1, value = as_paragraph(as_i("max"),"ABC (t)")) %>%
      compose(i = 14, j = 1, value = as_paragraph("")) %>%
      compose(i = 14, j = 2:3,
              value = as_paragraph( "As determined " , as_i("last"), " year for:")) %>%
      compose(i = 14, j = 4:5,
              value = as_paragraph( "As determined " , as_i("this"), " year for:")) %>%
      compose(i = 15, j = 2,
              value = as_paragraph(as_chunk(as.character(year - 1)))) %>%
      compose(i = 15, j = 3:4,
              value = as_paragraph(as_chunk(as.character(year)))) %>%
      compose(i = 15, j = 5,
              value = as_paragraph(as_chunk(as.character(year + 1)))) %>%
      compose(i=16, j=c(2,4), value = as_paragraph("No")) %>%
      compose(i=16, j=c(3,5), value = as_paragraph("n/a")) %>%
      compose(i=17:18, j=c(3,5), value = as_paragraph("No")) %>%
      compose(i=17:18, j=c(2,4), value = as_paragraph("n/a")) %>%
      colformat_double(i = c(3:7, 11:13), j = 2:5, big.mark=",", digits = 0, na_str = "N/A") %>%
      merge_h(i=14, part = "body") %>%
      bold(i = 15, j = 1) %>%
      hline(i=13) %>%
      hline(i=15) %>%
      hline(i=18) %>%
      fix_border_issues()

  } else if(tier==1){

    if(nrow(tbl$body$data)>17){
      stop("this is not a tier 1 input, \nmaybe you have a tier 3 stock...")
    }

    tier = "1a"

    tbl %>%
      footnote(i=2, j=4:5, part = "header", ref_symbols = "*",
               value = as_paragraph(as_chunk(paste0("Projections are based on an estimated catch of ",
                                                    prettyNum(c1, big.mark = ","), " t for ", year,
                                                    " and estimates of ",
                                                    prettyNum(c2, big.mark = ","),
                                                    " t and ",
                                                    prettyNum(c3, big.mark = ","),
                                                    " t used in place of maximum permissible ABC for ",
                                                    year+1, " and ", year+2, "."))),
               sep = ".") %>%
      compose(i = 2, j = 2:5, value = as_paragraph(tier), part = "body") %>%
      compose(i = 4, j = 1, value = as_paragraph("F", as_sub("OFL")), part = "body") %>%
      compose(i = 5, j = 1, value = as_paragraph(as_i("max"),"F", as_sub("ABC")), part = "body") %>%
      compose(i = 6, j = 1, value = as_paragraph("F", as_sub("ABC")), part = "body") %>%
      compose(i = 7, j = 1, value = as_paragraph(as_i("max"),"ABC (t)"), part = "body") %>%
      compose(i = 13, j = 1, value = as_paragraph("")) %>%
      compose(i = 13, j = 2:3,
              value = as_paragraph( "As determined " , as_i("last"), " year for:")) %>%
      compose(i = 13, j = 4:5,
              value = as_paragraph( "As determined " , as_i("this"), " year for:")) %>%
      compose(i = 14, j = 2,
              value = as_paragraph(as_chunk(as.character(year - 1)))) %>%
      compose(i = 14, j = 3:4,
              value = as_paragraph(as_chunk(as.character(year)))) %>%
      compose(i = 14, j = 5,
              value = as_paragraph(as_chunk(as.character(year + 1)))) %>%
      compose(i=15, j=c(2,4), value = as_paragraph("No")) %>%
      compose(i=15, j=c(3,5), value = as_paragraph("n/a")) %>%
      compose(i=16:17, j=c(3,5), value = as_paragraph("No")) %>%
      compose(i=16:17, j=c(2,4), value = as_paragraph("n/a")) %>%
      colformat_double(i = c(3:7, 10:12), j = 2:5, big.mark=",", digits = 0, na_str = "N/A") %>%
      merge_h(i=13, part = "body") %>%
      align(align = "center", part = "header") %>%
      align(j=2:5, align = "center", part = "body") %>%
      align(j = 1, part = "header", align="left") %>%
      bold(i = 2, j = 1, part = "header") %>%
      bold(i = 15, j = 1) %>%
      hline(i=12) %>%
      hline(i=14) %>%
      hline(i=17) %>%
      fix_border_issues()
  } else if(tier == 5){

    tier = "5"

    tbl %>%
      compose(i = 2, j = 2:5, value = as_paragraph(tier), part = "body") %>%
      compose(i = 4, j = 1, value = as_paragraph("F", as_sub("OFL")), part = "body") %>%
      compose(i = 5, j = 1, value = as_paragraph(as_i("max"),"F", as_sub("ABC")), part = "body") %>%
      compose(i = 6, j = 1, value = as_paragraph("F", as_sub("ABC")), part = "body") %>%
      compose(i = 8, j = 1, value = as_paragraph(as_i("max"),"ABC (t)"), part = "body") %>%
      compose(i = 10, j = 1, value = as_paragraph("")) %>%
      compose(i = 10, j = 2:3,
              value = as_paragraph( "As determined " , as_i("last"), " year for:")) %>%
      compose(i = 10, j = 4:5,
              value = as_paragraph( "As determined " , as_i("this"), " year for:")) %>%
      compose(i = 11, j = 2,
              value = as_paragraph(as_chunk(as.character(year - 1)))) %>%
      compose(i = 11, j = 3:4,
              value = as_paragraph(as_chunk(as.character(year)))) %>%
      compose(i = 11, j = 5,
              value = as_paragraph(as_chunk(as.character(year + 1)))) %>%
      compose(i=12, j=c(2,4), value = as_paragraph("No")) %>%
      compose(i=12, j=c(3,5), value = as_paragraph("n/a")) %>%
      colformat_double(i = c(3,7:9), j = 2:5, big.mark=",", digits = 0, na_str = "N/A") %>%
      merge_h(i=10, part = "body") %>%
      align(align = "center", part = "header") %>%
      align(j=2:5, align = "center", part = "body") %>%
      align(j = 1, part = "header", align="left") %>%
      hline(i=9) %>%
      hline(i=11) %>%
      hline(i=12) %>%
      fix_border_issues()
  } else {
    tier = "6"

    tbl %>%
      compose(i = 1, j = 2:5, value = as_paragraph(tier), part = "body") %>%
      compose(i = 3, j = 1, value = as_paragraph(as_i("max"),"ABC (t)"), part = "body") %>%
      compose(i = 5, j = 1, value = as_paragraph("")) %>%
      compose(i = 5, j = 2:3,
              value = as_paragraph( "As determined " , as_i("last"), " year for:")) %>%
      compose(i = 5, j = 4:5,
              value = as_paragraph( "As determined " , as_i("this"), " year for:")) %>%
      compose(i = 6, j = 2,
              value = as_paragraph(as_chunk(as.character(year - 1)))) %>%
      compose(i = 6, j = 3:4,
              value = as_paragraph(as_chunk(as.character(year)))) %>%
      compose(i = 6, j = 5,
              value = as_paragraph(as_chunk(as.character(year + 1)))) %>%
      compose(i=7, j=c(2,4), value = as_paragraph("No")) %>%
      compose(i=7, j=c(3,5), value = as_paragraph("n/a")) %>%
      colformat_double(i = c(2:4), j = 2:5, big.mark=",", digits = 0, na_str = "N/A") %>%
      merge_h(i=5, part = "body") %>%
      align(align = "center", part = "header") %>%
      align(j=2:5, align = "center", part = "body") %>%
      align(j = 1, part = "header", align="left") %>%
      hline(i=4) %>%
      hline(i=6) %>%
      hline(i=7) %>%
      fix_border_issues()
  }
}
