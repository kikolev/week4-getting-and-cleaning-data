# Utility functions that help main program

join_data_files = function(folder_path, file1, file2){
        # The function reads to files form a folder and joins them rowwise 
        
        if(!file.exists(folder_path)){ 
                return("warning: Missing folder path")
        }
        
        fullpath_file1 = file.path(folder_path,file1)
        fullpath_file2 = file.path(folder_path,file2)
        data1 = data2 = NULL
        
        # Confirm that the data files exist
        if(!file.exists(fullpath_file1) | !file.exists(fullpath_file2)){
                return("warning: File names are missing")
        }
        
        # Read the data files
        data1 = read.table(fullpath_file1 )
        data2 = read.table(fullpath_file2) 
        
        # Check the two files to make sure they have the same length
        if(length(data1)!=length(data2)){
                return("warning: The files have missmatched row number")
        }
        rbind(data1,data2)
        
}   


get_feature_cols_means_std = function(folder_path,features_file){
        # This function get the column numbers and names for fatures dataset which contain "mean" and "std" in name
        
        if(!file.exists(folder_path)){ 
                return("warning: Missing folder path")
        }
        
        fullpath_feature_file = file.path(folder_path,features_file)  
        
        if(!file.exists(fullpath_feature_file)){
                return("warning: Features file name is missing")
        }
        
        features = read.table(fullpath_feature_file)
        
        #get column numbers and names where description has mean or std in it
        col_name_ID =grep("mean|std",features[,2])
        col_name = grep("mean|std",features[,2],value = TRUE)
        
        # clean names for any special characters
        col_name = gsub("[()-]","",col_name)
        
        list("col_name_ID"=col_name_ID,"col_name"=col_name)
}

get_activity_names = function(folder_path, activity_file){
        # This function get the activity names as text corresponding to each number
        
        if(!file.exists(folder_path)){ 
                return("warning: Missing folder path")
        }
        
        fullpath_activity_file = file.path(folder_path,activity_file)  
        
        if(!file.exists(fullpath_activity_file)){
                return("warning: Activity file name is missing")
        }
        
        activities = read.table(fullpath_activity_file)
        
        activities    
}