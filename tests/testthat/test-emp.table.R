test_that("Emp Table Selects doses appropriately", {
  out_high <- emp.table(
    n.lo = 30,
    n.hi = 30,
    eff.hi = 16,
    eff.lo = 13,
    tox.hi = 5,
    tox.lo = 4,
    emp.eff.lo.thresh = .10,
    emp.eff.hi.thresh = .25,
    emp.tox.lo.thresh = 1.5,
    emp.tox.hi.thresh = 2,
    check.admiss = "Yes",
    c_T = 0.95,
    c_E = 0.90,
    phi_T = 0.45,
    phi_E = 0.3
  )

  expect_equal(as.character(out_high["Dose selection", "Empirical table output"]),
               "High dose")

  out_low <-
    emp.table(
      n.lo = 30,
      n.hi = 30,
      eff.hi = 12,
      eff.lo = 14,
      tox.hi = 6,
      tox.lo = 4,
      emp.eff.lo.thresh = .10,
      emp.eff.hi.thresh = .25,
      emp.tox.lo.thresh = 1.5,
      emp.tox.hi.thresh = 2,
      check.admiss = "Yes",
      c_T = 0.95,
      c_E = 0.90,
      phi_T = 0.45,
      phi_E = 0.3
    )

  expect_equal(as.character(out_low["Dose selection", "Empirical table output"]),
               "Low dose")
})
