test_that("manufacture_ldt_long_data generates a tibble",{
  expect_equal(c("tbl_df", "tbl", "data.frame"), class(manufacture_ldt_long_data()))
})
