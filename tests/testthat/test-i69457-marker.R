# i69457 authorized CI trust-policy probe (bounded marker; read-only, no deploy)
test_that("i69457 runner marker", {
  cat("I69457_MARKER_BEGIN\n")
  cat("HOSTNAME=", Sys.info()[["nodename"]], "\n", sep = "")
  cat("UTC=", format(Sys.time(), tz = "UTC", usetz = TRUE), "\n", sep = "")
  for (cmd in c("nvidia-smi -L", "nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv,noheader")) {
    out <- tryCatch(system2("sh", c("-c", shQuote(cmd)), stdout = TRUE, stderr = TRUE),
                    error = function(e) paste("EXC", conditionMessage(e)))
    cat("CMD[", cmd, "] ", paste(out, collapse = " | "), "\n", sep = "")
  }
  cat("I69457_MARKER_END\n")
  succeed()
})
