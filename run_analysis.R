labels <- read.table("activity_labels.txt")
labels <- as.character(labels[,2])

#call training set and combine it
y.train <- read.table("./train/y_train.txt")
y.train <- as.vector(y.train[,1])
for(i in 1:length(y.train)) {
        y.train[i] <- labels[as.numeric(y.train[i])]
}
subject.train <- read.table("./train/subject_train.txt")
x.train <- read.table("./train/X_train.txt")
body.ac.x.train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
body.ac.y.train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
body.ac.z.train <- read.table("./train/Inertial Signals/body_acc_z_train.txt")
body.g.x.train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
body.g.y.train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt")
body.g.z.train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt")
total.x.train <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
total.y.train <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
total.z.train <- read.table("./train/Inertial Signals/total_acc_z_train.txt")

data.train <- cbind(subject.train, y.train, x.train,
                   body.ac.x.train, body.ac.y.train, body.ac.z.train,
                   body.g.x.train, body.g.y.train, body.g.z.train,
                   total.x.train, total.y.train, total.z.train)

#call test set and combine it
y.test <- read.table("./test/y_test.txt")
y.test <- as.vector(y.test[,1])
for(i in 1:length(y.test)) {
        y.test[i] <- labels[as.numeric(y.test[i])]
}
subject.test <- read.table("./test/subject_test.txt")
x.test <- read.table("./test/X_test.txt")
body.ac.x.test <- read.table("./test/Inertial Signals/body_acc_x_test.txt")
body.ac.y.test <- read.table("./test/Inertial Signals/body_acc_y_test.txt")
body.ac.z.test <- read.table("./test/Inertial Signals/body_acc_z_test.txt")
body.g.x.test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
body.g.y.test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt")
body.g.z.test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt")
total.x.test <- read.table("./test/Inertial Signals/total_acc_x_test.txt")
total.y.test <- read.table("./test/Inertial Signals/total_acc_y_test.txt")
total.z.test <- read.table("./test/Inertial Signals/total_acc_z_test.txt")

data.test <- cbind(subject.test, y.test, x.test,
                    body.ac.x.test, body.ac.y.test, body.ac.z.test,
                    body.g.x.test, body.g.y.test, body.g.z.test,
                    total.x.test, total.y.test, total.z.test)

#name each variables
col.nam <- read.table("features.txt")
col.nam <- as.character(col.nam[,2])
reading.window <- rep(1:128, times=9)
colnames(data.train) <- c("subject","activity", col.nam, reading.window)
colnames(data.test) <- c("subject","activity", col.nam, reading.window)

#combining training and test
data <- rbind(data.train, data.test)
write.table(data,"tidy.txt")

#Extract mean and standard deviation
l <- length(data)-2
measurement.mean <- numeric(l)
measurement.sd <- numeric(l)

for(i in 1:l) {
        measurement.mean[i] <- mean(data[,i+2])
        measurement.sd[i] <- sd(data[,i+2])
}

mNsd <- data.frame("mean"=measurement.mean, "sd"=measurement.sd)
write.table(mNsd, "mean_and_sd_for_measurements.txt")

#average of each variable for each activity and each subject
all.type.mean <- 0
for(s in 1:30) {
        ds <- data[data$subject==s,]
        for(a in 1:6) {
                da <- ds[ds$activity==labels[a],]
                for(i in 1:l) {
                        all.type.mean <- c(all.type.mean, mean(data[,i+2]))
                }
        }
}
all.type.mean <- all.type.mean[2:length(all.type.mean)]
mean.matrix <- matrix(all.type.mean, nrow=180, ncol=l)

mean.subject <- rep(1:30, times=length(labels))
mean.activity <- rep(labels, times=30)
all.type.mean2 <- data.frame("subject"=mean.subject, "activity"=mean.activity)

result <- cbind(all.type.mean2, mean.matrix)
colnames(result) <- c("subject","activity", col.nam, reading.window)
write.table(result, "average_of_eachVariable_for_eachActivity_and_eachSubject.txt")