analyze_wearable_data <- function() {
  
  #
  # Import the data
  #
  
  #the folder name in the working directory
  fname = "UCI Har Dataset"
  
  activity_label <- read.table(paste(fname, "/activity_labels.txt", sep = ""))
  features <- read.table(paste(fname, "/features.txt", sep = ""))
  
  #vector of different folders
  folders = c("test", "train")
  
  #vector of different files in each folders
  files = c("subject", "X", "y")
  
  #vector of files in Inertial folder
  innerfiles = c("body_acc_", "body_gyro_", "total_acc_")
  
  #counter
  folder_count = 1
  
  while (folder_count <= length(folders)) 
    
    {
    curr_folder = folders[folder_count]
    
    file_count = 1 
    
    while (file_count <= length(files))
    {
      
      curr_file = files[file_count]
      
      assign(paste(curr_file, "_", curr_folder, sep = ""),
             read.table(paste(fname, "/", curr_folder, "/", curr_file, "_", curr_folder, ".txt", sep = "")))
      
      file_count = file_count + 1
      
    }
    
    folder_count = folder_count + 1
  }
  
  #
  # Step 1
  #  Merge test and training sets
  #
  
  combine = c("X", "subject", "y")
  
  combine_count = 1
  
  while (combine_count <= length(combine))
  {
    assign(paste(combine[combine_count], "", sep="") , rbind(get(paste(combine[combine_count], "_test", sep = "")),
                                                        get(paste(combine[combine_count], "_train", sep = ""))))
    
    combine_count = combine_count + 1
    
  }
  
  #
  # Set column names based on features (Step 3)
  #
  colnames(X) <- features[,2]
  colnames(subject) <- "subject"
  colnames(y) <- "activity"
  
  # and for activity name
  colnames(activity_label) <- c("activity", "activity_name")
  
  #
  # Step 2
  #  Extracts std deviation and mean for combined data
  #
  
  total_avg <- subset(aggregate(cbind(subject,y,X), cbind(subject, y, X)[c(1,2)], mean), select = -c(3,4))
  
  total_std <- subset(aggregate(cbind(subject,y,X), cbind(subject, y, X)[c(1,2)], sd), select = -c(3,4))
  
  #
  # Merging in activity name- for averages
  #
  final_data <- subset(merge(activity_label, total_avg, by="activity"), select = -c(1))
  
}
