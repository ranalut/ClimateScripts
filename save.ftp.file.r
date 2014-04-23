
# New version is more generalized to look at the file names on the ftp site and pull down the file, whatever it is called.  This deals with some of the finicky differences in file names mostly relating to the years (start/stop) and whether the GCM model name is listed in capital letters.

setInternet2(TRUE)

save.ftp.file <- function(model, rcp, variable) # , start.yr, end.yr)
{
	cat(model[1],rcp,variable,'\n')
	
	output.folder <- paste('D:/CMIP5_Climate_Data/Bureau_of_Reclamation/',model[1],sep='')
	dir.create(output.folder,recursive=TRUE)
		
	ftp.address <- paste('ftp://gdo-dcp.ucllnl.org/pub/dcp/archive/cmip5/bcsd/BCSD/',model[1],'/rcp',rcp,'/mon/r1i1p1/',variable,'/',sep='')
	download.file(ftp.address, 'temp.file.names.txt')
	temp <- readLines('temp.file.names.txt')
	file.name <- temp[grep('A HREF="/',temp)]
	file.name <- as.character(strsplit(file.name, '"')[[1]])
	# print(file.name); stop('cbw')
	file.name <- file.name[grep('/pub/dcp/archive/',file.name)]
	# print(file.name); stop('cbw')
	file.address <- paste('ftp://gdo-dcp.ucllnl.org', file.name, sep='')
	print(file.address)
	
	output.file <- as.character(strsplit(file.address, '/')[[1]])
	# print(output.file); stop('cbw')
	output.file <- paste(output.folder,'/',output.file[length(output.file)],sep='')
	ifelse(file.exists(output.file),return(),download.file(file.address,output.file))
	# stop('cbw')
}

# Load model names
model.table <- read.csv('d:/cmip5_climate_data/bureau_of_reclamation_cmip5_all_v2.csv',header=TRUE, stringsAsFactors=FALSE)
print(model.table)

# Select models to download
model.table <- model.table[c(2,3,4,6,9,11,13,16,18),]
print(model.table)
# stop('cbw')

all.rcp <- c(26,45,60,85)
# all.var <- c('pr','tas','tasmax','tasmin')
all.var <- c('pr','tas')

# Function call
for (i in 9:length(model.table))
{
	for (j in all.rcp)
	{
		for (n in all.var)
		{
			save.ftp.file(
				model=as.character(model.table[i]), # model=as.character(model.table[i,c(1,3)]), # 'bcc-csm1-1',
				rcp=j, # 26,
				variable=n # ,
				# start.yr=model.table[i,'start.yr'],
				# end.yr=model.table[i,'end.yr'] # 2099
				)
			# stop('cbw')
		}
	}
	# stop('cbw')
}

	
# ===============================================================
# Scratch code
# ===============================================================


# bin = getBinaryURL(downloadURL, ...yourOtherParams...) 
# writeBin(bin, "temp.rData")  
# load("temp.rData")

# address <- 'ftp://gdo-dcp.ucllnl.org/pub/dcp/subset/201312101533NXX001_0Oa1lc/bcsd5.tar.gz'
# temp <- getBinaryURL(url=address)
# writeBin(temp,'d:/cmip5_climate_data/giss-er2-r/rcp6/bcsd5.tar.gz')

# save.ftp.file <- function(address, model, rcp)
# {
  # temp <- getBinaryURL(url=address, connecttimeout=200)
  # dir.create(paste('d:/cmip5_climate_data/',model,'/rcp',model,'/bcsd5.tar.gz',sep=''))
  # writeBin(temp,paste('d:/cmip5_climate_data/',model,'/rcp',model,'/bcsd5.tar.gz',sep=''))  
# }

# save.ftp.file(
  # address='ftp://gdo-dcp.ucllnl.org/pub/dcp/subset/201312101533NXX001_0Oa1lc/bcsd5.tar.gz',
  # model='giss-er2-r',
  # rcp=6
  # )

# Should allow me to make a number of requests and then look through the downloads (eg, ftp addresses) overnight.


# The website for all the archives is: http://gdo-dcp.ucllnl.org/downscaled_cmip_projections/dcpInterface.html#Projections:%20Complete%20Archives. You will need the Archive of CONUS 1/8 & 1 degree BCSD files. This ftp link includes the 1/8 (~12km) monthly historical and future data.
# 
# I was thinking the best way to mine the data would be to write a script in R to go to the ftp and scroll through each of the ftp files and do a data download (see command below).
# For example to download from the ftp site (you can set this up to run iteratively by making a list of the directories in the ftp that you want):
#   
# url <- "ftp://gdo-dcp.ucllnl.org/pub/dcp/archive/cmip5/bcsd/BCSD/access1-0/rcp45/mon/r1i1p1/pr/BCSD_0.125deg_pr_Amon_ACCESS1-0_rcp45_r1i1p1_200601-210012.nc"
# dest <- "D:/ CMIP5_Climate_Data/XX.nc"
# download.file(url, dest)  


