# context ------------------------------------------------------------
context(desc = "ggscatterstats")

# pearson's r with NAs ---------------------------------------------

testthat::test_that(
  desc = "checking ggscatterstats - without NAs - pearson's r",
  code = {
    # creating the plot
    set.seed(123)
    p <-
      ggstatsplot::ggscatterstats(
        data = ggplot2::msleep,
        x = sleep_total,
        y = bodywt,
        label.var = "name",
        label.expression = "bodywt > 2000",
        xlab = "sleep (total)",
        ylab = "body weight",
        type = "p",
        messages = FALSE,
        centrality.para = "mean",
        marginal = FALSE,
        bf.message = TRUE,
        caption = "ggplot2 dataset",
        title = "Mammalian sleep"
      )

    # plot build
    pb <- ggplot2::ggplot_build(p)

    # checking data used to create a plot
    dat <- tibble::as_tibble(p$data) %>%
      dplyr::mutate_if(
        .tbl = .,
        .predicate = is.factor,
        .funs = ~ as.character(.)
      )

    # checking dimensions of data
    data_dims <- dim(dat)
    ggrepel_dims <- dim(p$plot_env$label_data)

    # testing everything is okay with data
    testthat::expect_equal(data_dims[1], 83L)
    testthat::expect_equal(data_dims[2], 13L)
    testthat::expect_equal(
      ggrepel_dims[1],
      dim(dplyr::filter(ggplot2::msleep, bodywt > 2000))[1]
    )
    testthat::expect_equal(ggrepel_dims[2], 13L)
    testthat::expect_equal(p$plot_env$x_label_pos, 10.88401, tolerance = 0.002)
    testthat::expect_equal(p$plot_env$x_median, 10.1000, tolerance = 0.002)
    testthat::expect_equal(p$plot_env$x_mean, 10.43373, tolerance = 0.002)
    testthat::expect_equal(p$plot_env$y_label_pos, 2954.955, tolerance = 0.002)
    testthat::expect_equal(p$plot_env$y_median, 1.6700, tolerance = 0.002)
    testthat::expect_equal(p$plot_env$y_mean, 166.1363, tolerance = 0.002)

    # subtitle
    set.seed(123)
    p_subtitle <- ggstatsplot::subtitle_ggscatterstats(
      data = ggplot2::msleep,
      x = sleep_total,
      y = bodywt,
      type = "p",
      messages = FALSE
    )

    # checking plot labels
    testthat::expect_identical(p$plot_env$caption, ggplot2::expr(atop(
      "ggplot2 dataset",
      expr = paste(
        "In favor of null: ",
        "log"["e"],
        "(BF"["01"],
        ") = ",
        "-2.23",
        ", Prior width = ",
        "0.71"
      )
    )))
    testthat::expect_identical(p$plot_env$title, "Mammalian sleep")
    testthat::expect_identical(p$plot_env$subtitle, p_subtitle)
    testthat::expect_identical(pb$plot$labels$x, "sleep (total)")
    testthat::expect_identical(pb$plot$labels$y, "body weight")
    testthat::expect_identical(p$plot_env$label_data$name[1], "Asian elephant")
    testthat::expect_identical(p$plot_env$label_data$name[2], "African elephant")
  }
)

# spearman's rho with NAs ---------------------------------------------

testthat::test_that(
  desc = "checking ggscatterstats - without NAs - spearman's rho",
  code = {
    # creating the plot
    set.seed(123)
    p <-
      ggstatsplot::ggscatterstats(
        data = ggplot2::msleep,
        x = sleep_total,
        y = bodywt,
        type = "np",
        conf.level = 0.99,
        marginal = FALSE,
        messages = FALSE
      )

    # subtitle
    set.seed(123)
    p_subtitle <- ggstatsplot::subtitle_ggscatterstats(
      data = ggplot2::msleep,
      x = sleep_total,
      y = bodywt,
      type = "np",
      conf.level = 0.99,
      messages = FALSE
    )

    testthat::expect_identical(p$plot_env$subtitle, p_subtitle)
  }
)


# percentage bend with NAs ---------------------------------------------

testthat::test_that(
  desc = "checking ggscatterstats - without NAs - percentage bend",
  code = {
    # creating the plot
    set.seed(123)
    p <-
      ggstatsplot::ggscatterstats(
        data = ggplot2::msleep,
        x = sleep_total,
        y = bodywt,
        type = "r",
        centrality.para = "mean",
        conf.level = 0.90,
        marginal = FALSE,
        messages = FALSE
      )

    # subtitle
    set.seed(123)
    p_subtitle <- ggstatsplot::subtitle_ggscatterstats(
      data = ggplot2::msleep,
      x = sleep_total,
      y = bodywt,
      type = "r",
      conf.level = 0.90,
      messages = FALSE
    )

    # built plot
    pb <- ggplot2::ggplot_build(p)

    testthat::expect_identical(p$plot_env$subtitle, p_subtitle)

    testthat::expect_equal(pb$data[[3]]$xintercept[[1]],
      mean(ggplot2::msleep$sleep_total, na.rm = TRUE),
      tolerance = 1e-3
    )
    testthat::expect_equal(pb$data[[4]]$yintercept[[1]],
      mean(ggplot2::msleep$bodywt, na.rm = TRUE),
      tolerance = 1e-3
    )
  }
)


# checking median display ---------------------------------------------

testthat::test_that(
  desc = "checking median display",
  code = {
    # creating the plot
    set.seed(123)

    # plot
    p <-
      ggstatsplot::ggscatterstats(
        data = ggplot2::msleep,
        x = sleep_cycle,
        y = awake,
        marginal = FALSE,
        centrality.para = "median",
        messages = FALSE
      )

    # built plot
    pb <- ggplot2::ggplot_build(p)

    # checking intercepts
    testthat::expect_equal(pb$plot$plot_env$x_label_pos, 0.8066451, tolerance = 1e-3)
    testthat::expect_equal(pb$plot$plot_env$y_label_pos, 13.37923, tolerance = 1e-3)
    testthat::expect_equal(pb$data[[3]]$xintercept[[1]],
      median(ggplot2::msleep$sleep_cycle, na.rm = TRUE),
      tolerance = 1e-3
    )
    testthat::expect_equal(pb$data[[4]]$yintercept[[1]],
      median(ggplot2::msleep$awake, na.rm = TRUE),
      tolerance = 1e-3
    )
  }
)