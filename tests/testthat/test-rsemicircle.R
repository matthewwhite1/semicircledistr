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

test_that("rsemicircle produces an error when n is negative", {
  ## Try to generate 10 random values with n = -7
  expect_error(rsemicircle(10, -7))
})
