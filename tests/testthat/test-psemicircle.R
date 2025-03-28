test_that("psemicircle requires positive R", {
  x <- 1
  R <- -1
  expect_error(psemicircle(x, R), "R must be positive.")
})

test_that("x must be within radius", {
  x <- -1.6
  R <- 1.5
  expect_error(psemicircle(x, R), "x must be within radius.")
})

test_that("psemicircle works with single input", {
  x <- 1
  R <- 2
  expected <- 0.8045
  actual <- psemicircle(x, R)
  expect_equal(actual, expected, tolerance=1e-4)
})

test_that("psemicircle works with vector", {
  x <- c(-2, -1, 0, 1, 2)
  R <- 2
  expected <- c(0, 1-0.8045, .5, 0.8045, 1)
  actual <- psemicircle(x, R)
  expect_equal(actual, expected, tolerance=1e-4)
})
