library(tensorflow)
install_tensorflow()

library(keras)
use_implementation("tensorflow")

library(tensorflow)
tfe_enable_eager_execution(device_policy = "silent")

library(purrr)
library(glue)