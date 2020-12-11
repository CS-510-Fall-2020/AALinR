#########################################################
#                                                       #
#      Average Annualized Loss in R (AALinR)            #
#                        by                             #
#                   Niko Todorov                        #
#                                                       #
#########################################################
install.packages("tidyr")
install.packages("ggplot2")
install.packages("ggthemes")
install.packages("maps")
library(tidyr)
library(ggplot2)
library(ggthemes)
library(maps)
# adjacent intervals
C.10.20   <- 0.025  # 0.5/10-0.5/20
C.20.50   <- 0.015  # 0.5/20-0.5/50
C.50.100  <- 0.005  # 0.5/50-0.5/100
C.100.200 <- 0.0025 # 0.5/100-0.5/200
C.200.500 <- 0.0015 # 0.5/200-0.5/500
C.10.25   <- 0.03   # 0.5/10-0.5/25
C.25.50   <- 0.01   # 0.5/25-0.5/50
C.100.500 <- 0.004  # 0.5/100-0.5/500

#########################################################
# The LA6 hurricane loss dataset is an almost complete  #
# dataset with no blanks/missing data, because it is    #
# based on Census Tracts (CT) which are almost certainly#
# guaranteed to contain a non-enpty Census Blocks (CB)  #
# in terms of building exposure. Such completeness makes#
# LA6 easy to compute the AAL utilizing the Rietmann    # 
# sums numerical integration.                           #
#########################################################
LA6.norm <- read.table("dat\\LA6.txt")
colnames(LA6.norm) <- c("CT", "RP", "Loss")
LA6.norm[, 2] <- sapply(LA6.norm[, 2], as.integer)
LA6.norm[, 3] <- sapply(LA6.norm[, 3], as.numeric)
LA6.norm <- LA6.norm [-1, ]
LA6 <- LA6.norm %>% pivot_wider(names_from <- RP, values_from <- Loss) # , values_fill <- 0

LA6 <- subset(LA6, select <- c(1,2,4,5,6,7,8,3))
LA6$`AAL`<-C.10.20*(LA6$`10`+LA6$`20`)
          +C.20.50*(LA6$`20`+LA6$`50`)
          +C.50.100*(LA6$`50`+LA6$`100`)
          +C.100.200*(LA6$`100`+LA6$`200`)
          +C.200.500*(LA6$`200`+LA6$`500`)
ggplot(data <- LA6.norm, mapping <- aes(x<-as.factor(RP), y<-log(Loss), fill<-as.factor(RP))) + geom_violin() # geom_point() # geom_contour
ggsave()

# write.table(LA6, "dat\\LA6AAL.txt")
# write.csv(LA6, "dat\\LA6.AAL.csv")
# qplot(LA6$CT, LA6$AAL, data<-LA6, geom<-c("point","smooth"))
# bp <- ggplot(LA6.norm, aes(x<-as.numeric(RP),y<-as.numeric(CT)))
# bp
# summary(LA6)

#########################################################
# The NOLA flood loss dataset is sparse as compared to  #
# the LA6 hurricane loss one. Considering such sparcity #
# and ensuing consequent complexity of dynamic range    #
# numerical integration using the Rietmann sums the     #
# development of AAL methodology for NOLA dataset is    #
# considered out-of-scope for the purposes of CS-510.   #
#########################################################
NOLA.norm <- read.table("dat\\NOLA.txt")
colnames(NOLA.norm) <- c("CB", "RP", "Loss")
NOLA.norm[, 2] <- sapply(NOLA.norm[, 2], as.integer)
NOLA.norm[, 3] <- sapply(NOLA.norm[, 3], as.numeric)
NOLA.norm <- NOLA.norm [-1, ]
NOLA <- NOLA.norm %>% pivot_wider(names_from <- RP, values_from <- Loss) # values_fill <- 0
NOLA <- subset(NOLA, select <- c(1,4,5,3,2,6))
# TODO: NOLA later
#NOLA$`AAL`<-C.10.25*(NOLA$`10`+NOLA$`25`)+C.25.50*(NOLA$`25`+NOLA$`50`)+C.50.100*(NOLA$`50`+NOLA$`100`)+C.100.500*(NOLA$`100`+NOLA$`500`)
# TODO: roll up CB/CT to and plot at county level
#data(county.fips)
