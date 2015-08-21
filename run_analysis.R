
kinematic_func <- function(dir = '/Users/tomathy/Downloads/UCI HAR Dataset/'){
  
  library('plyr')
  
  variable_list <- read.table(paste(dir,'features.txt', sep=''))
  activity_list <- read.table(paste(dir,'activity_labels.txt', sep=''))
  
  #   for(i in variable_list$V2) {
  #     
  #     if(substr(i, 1,1) == 't') {
  #       analysis_type <- 'Timeseries'
  #     } else {
  #       analysis_type <- 'FFT'
  #     }
  #     
  #     if(grepl('BodyAcc-',i)) subject <- 'LinearAccel.'
  #     if(grepl('GravityAcc-',i)) subject <- 'Gravity'
  #     if(grepl('BodyAccJerk-',i)) subject <- 'LinearJerk'
  #     if(grepl('BodyGyro-',i)) subject <- 'RotationalAccel.'
  #     if(grepl('BodyGyroJerk-',i)) subject <- 'RotationalJerk'
  #     if(grepl('BodyAccMag',i)) subject <- 'LinearAcceleration'
  #     
  #     if(grepl('mean()',i)) {
  #       action <- 'Mean'
  #     }
  #     
  #     if(grepl('std()',i)) {
  #       action <- 'Std.Dev.'
  #     }
  #     
  #     
  #     
  #     
  #   }
  
  mean_index = grep('mean()', variable_list$V2, fixed = T)
  std_index = grep('std()', variable_list$V2, fixed = T)
  combined_index = sort(c(mean_index,std_index))
  
  result <- variable_list$V2[combined_index]
  
  activity_data1 <- read.table(paste(dir,'test/y_test.txt', sep=''), col.names='Activity')
  activity_data2 <- read.table(paste(dir,'train/y_train.txt', sep=''), col.names='Activity')
  activity_data <- rbind(activity_data1, activity_data2)
  activity_data <- as.factor(activity_data$Activity)
  activity_data <- mapvalues(activity_data, from = as.character(activity_list$V1), 
                            to = as.character(activity_list$V2))
  
  raw_data1 <- read.table(paste(dir,'test/X_test.txt', sep=''), col.names=variable_list$V2)
  raw_data2 <- read.table(paste(dir,'train/X_train.txt', sep=''), col.names=variable_list$V2)
  
  raw_data <- rbind(raw_data1, raw_data2)
  raw_data <- raw_data[,combined_index]
  
  data <- cbind(activity_data, raw_data)
  
  tidy <- aggregate(data[2:67], list('Activity'=data$activity_data), mean)
  
  tidy_variable_list <- variable_list[combined_index,2]
  write.table(tidy_variable_list, row.name = F, file=paste(dir,'tidy_codebook.txt', sep=''))
  write.table(tidy, row.name = F, file = paste(dir,'tidy_data.txt', sep=''))
  
  tidy
  
}