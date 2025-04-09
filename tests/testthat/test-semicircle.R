## psemicircle

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


## rsemicircle

test_that("rsemicircle produces the correct number of random values", {
  ## Generate 20 random values
  x <- rsemicircle(20, 7)

  ## Check that the length of x is correct
  expect_equal(length(x), 20)
})

test_that("rsemicircle produces random values within the correct range", {
  ## Generate 20 random values
  x <- rsemicircle(20, 7)

  ## Check that the values are within the correct range
  expect_true(all(x >= -7))
  expect_true(all(x <= 7))
})

test_that("rsemicircle produces different random values each time", {
  ## Generate 20 random values
  x1 <- rsemicircle(20, 7)

  ## Generate 20 more random values
  x2 <- rsemicircle(20, 7)

  ## Check that the two sets of random values are different
  expect_false(identical(x1, x2))
})

test_that("rsemicircle produces an error when num is not an integer", {
  ## Try to generate 10.5 random values
  expect_error(rsemicircle(10.5, 7))
})

test_that("rsemicircle produces an error when num is negative", {
  ## Try to generate -10 random values
  expect_error(rsemicircle(-10, 7))
})

test_that("rsemicircle produces an error when R is negative", {
  ## Try to generate 10 random values with R = -7
  expect_error(rsemicircle(10, -7))
})

test_that("rsemicircle produces random values within the correct range with 'a'", {
  ## Generate 20 random values
  x <- rsemicircle(20, 7, 10)

  ## Check that the values are within the correct range
  expect_true(all(x >= 3))
  expect_true(all(x <= 17))
})
