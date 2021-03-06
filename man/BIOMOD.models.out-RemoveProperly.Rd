\name{BIOMOD.models.out-RemoveProperly}

\alias{RemoveProperly}
\alias{RemoveProperly,BIOMOD.models.out-method}

\title{ remove properly BIOMOD_Modeling outputs}

\description{ 
Functions to free properly a \code{\link[biomod2]{BIOMOD_Modeling}} outputs
}

\usage{
  RemoveProperly(obj, obj.name=deparse(substitute(obj)), ...)
}



\arguments{
  \item{obj}{ \code{"\link[=BIOMOD.models.out-class]{BIOMOD.models.out}"} object }
  \item{obj.name}{ the name of object in current environment, automatically filled }
  \item{...}{ extra arguments (not implemented yet) }
}

\details{
  This function will remove all objects created during a \code{biomod2} modeling run. It will free both objects saved in memory and objects saved on hard drive.
}

\author{ Wilfried Thuiller, Damien Georges}

\seealso{ \code{\link{help}}}

\examples{
  \dontrun{
  # species occurrences
  DataSpecies <- read.csv(system.file("external/species/mammals_table.csv",
                                    package="biomod2"), row.names = 1)
  head(DataSpecies)
  
  # the name of studied species
  myRespName <- 'VulpesVulpes'
  
  # the presence/absences data for our species 
  myResp <- as.numeric(DataSpecies[,myRespName])
  
  # the XY coordinates of species data
  myRespXY <- DataSpecies[,c("X_WGS84","Y_WGS84")]
  
  
  # Environmental variables extracted from BIOCLIM (bio_3, bio_4, bio_7, bio_11 & bio_12)
  myExpl = stack( system.file( "external/bioclim/current/bio3.grd", 
                       package="biomod2"),
                  system.file( "external/bioclim/current/bio4.grd", 
                               package="biomod2"), 
                  system.file( "external/bioclim/current/bio7.grd", 
                               package="biomod2"),  
                  system.file( "external/bioclim/current/bio11.grd", 
                               package="biomod2"), 
                  system.file( "external/bioclim/current/bio12.grd", 
                               package="biomod2"))
  
  # 1. Formatting Data
  myBiomodData <- BIOMOD_FormatingData(resp.var = myResp,
                                       expl.var = myExpl,
                                       resp.xy = myRespXY,
                                       resp.name = myRespName)
  
  # 2. Defining Models Options using default options.
  myBiomodOption <- BIOMOD_ModelingOptions()
  
  # 3. Doing Modelisation
  
  myBiomodModelOut <- BIOMOD_Modeling( myBiomodData, 
                                       models = c('SRE'), 
                                       models.options = myBiomodOption, 
                                       NbRunEval=1, 
                                       DataSplit=80, 
                                       Prevalence=0.5, 
                                       VarImport=0, 
                                       models.eval.meth = c('TSS','ROC'),
                                       do.full.models=FALSE,
                                       modeling.id="test2")
  
  # files have been created on hard drive
  list.files(myRespName,all.files=TRUE,recursive=TRUE)
  
  # remove properly the modeling objects and all the file saved on hard drive
  RemoveProperly(myBiomodModelOut)
  
  # check files had been removed
  list.files(myRespName,all.files=TRUE,recursive=TRUE)
  }
}

\keyword{ models }
