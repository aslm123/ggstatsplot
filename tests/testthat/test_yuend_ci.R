context("test_yuend_ci_paired")

testthat::test_that(
  desc = "Yuen's test on trimmed means for dependent samples works",
  code = {
    testthat::skip_on_cran()

    # made up data
    mydata <-
      structure(list(
        time = structure(
          c(
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            1L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L,
            2L
          ),
          .Label = c("test1", "test2"),
          class = "factor"
        ),
        grade = c(
          42.9,
          51.8,
          71.7,
          51.6,
          63.5,
          58,
          59.8,
          50.8,
          62.5,
          61.9,
          50.4,
          52.6,
          63,
          58.3,
          53.3,
          58.7,
          50.1,
          64.2,
          57.4,
          57.1,
          44.6,
          54,
          72.3,
          53.4,
          63.8,
          59.3,
          60.8,
          51.6,
          64.3,
          63.2,
          51.8,
          52.2,
          63,
          60.5,
          57.1,
          60.1,
          51.7,
          65.6,
          58.3,
          60.1
        )
      ),
      row.names = c(NA, -40L),
      class = "data.frame"
      )

    # ggstatsplot output
    set.seed(123)
    df1 <-
      ggstatsplot:::yuend_ci(
        data = mydata,
        x = time,
        y = grade
      )

    # creating a dataframe with NAs
    mydata1 <- purrr::map_df(
      .x = mydata,
      .f = ~ .[sample(
        x = c(TRUE, NA),
        prob = c(0.8, 0.2),
        size = length(.),
        replace = TRUE
      )]
    )

    # creating a dataframe
    set.seed(123)
    df2 <-
      ggstatsplot:::yuend_ci(
        data = mydata1,
        x = time,
        y = grade,
        conf.level = 0.90,
        conf.type = "basic"
      )

    # percentile CI
    set.seed(123)
    df3 <-
      ggstatsplot:::yuend_ci(
        data = mydata1,
        x = time,
        y = grade,
        conf.level = 0.50,
        conf.type = "perc"
      )

    # bca CI
    set.seed(123)
    df4 <-
      suppressWarnings(ggstatsplot:::yuend_ci(
        data = mydata1,
        x = time,
        y = grade,
        conf.level = 0.85,
        conf.type = "bca"
      ))

    # testing (dataframe without NAs)
    testthat::expect_equal(df1$t.value, -5.268876, tolerance = .001)
    testthat::expect_equal(df1$xi, 0.166875, tolerance = 0.0001)
    testthat::expect_equal(df1$conf.low, 0.07917537, tolerance = 0.0001)
    testthat::expect_equal(df1$conf.high, 0.2513106, tolerance = 0.001)
    testthat::expect_equal(df1$df, 15L)
    testthat::expect_equal(df1$p.value, 0.0000945, tolerance = 0.000001)

    # testing (dataframe with NAs)
    testthat::expect_equal(df2$t.value, -0.3976015, tolerance = .001)
    testthat::expect_equal(df2$xi, 0.1607089, tolerance = 0.0001)
    testthat::expect_equal(df2$conf.low, -0.408429, tolerance = 0.0001)
    testthat::expect_equal(df2$conf.high, 0.3024555, tolerance = 0.001)
    testthat::expect_equal(df2$df, 7L)
    testthat::expect_equal(df2$p.value, 0.7027698, tolerance = 0.000001)

    # testing (dataframe with NAs + percentile CI)
    testthat::expect_equal(df3$xi, 0.1607089, tolerance = 0.0001)
    testthat::expect_equal(df3$conf.low, 0.1566501, tolerance = 0.0001)
    testthat::expect_equal(df3$conf.high, 0.4350129, tolerance = 0.0001)

    # testing (dataframe with NAs + bca CI)
    testthat::expect_equal(df4$xi, 0.1607089, tolerance = 0.0001)
    testthat::expect_equal(df4$conf.low, 0.00291321, tolerance = 0.0001)
    testthat::expect_equal(df4$conf.high, 0.3079085, tolerance = 0.0001)
  }
)
