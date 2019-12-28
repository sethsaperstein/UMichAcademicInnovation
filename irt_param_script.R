library("ltm")
library("stringr")

split_path <- function(x) if (dirname(x)==x) x else c(basename(x),split_path(dirname(x)))
files <- list.files(path="/Users/sethsaps/Desktop/AI/answers", pattern="*.csv", full.names=TRUE, recursive=FALSE)
lapply(files, function(x) {
  print(x)
  irt_data = read.csv(x, header=TRUE, sep=",") # load file
  irt_data = subset(irt_data, select = -user_id)
  model = PL1.rasch<-rasch(irt_data)
  #model = PL2.rasch<-ltm(irt_data~z1)
  #model = PL3.rasch<-tpm(irt_data, na.action=NULL, type='rasch')
  params = coef(model)
  plot(model, type="ICC")
  item.fit(model)

  out_name = str_trim(split_path(x)[1])
  
  write.csv(params, paste0("/Users/sethsaps/Desktop/AI/parameters/",out_name))
})
warnings()


