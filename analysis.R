df2 <- df
# as.numeric() converts values into numbers
# suppressWarnings() if some values cannot be converted 
# those values will become NA
df2$streams_num <- suppressWarnings(as.numeric(df2$streams))
# count how many NA we get
sum(is.na(df2$streams_num))
# remove rows where streams_num is NA
df2 <- df2[!is.na(df2$streams_num), ]
df2$group <- ifelse(df2$artist_count == 1, 'solo', 'collab')
df2$log_streams <- log(df2$streams_num)
df2$charted <- ifelse(df2$in_spotify_charts > 0, 1, 0)
x <- df2$log_streams[df2$group == 'collab']
y <- df2$log_streams[df2$group == 'solo']
t.test(x, y, alternative = 'greater')
prop.test(c(218, 330), c(366, 586), alternative = 'greater')
power.prop.test(p1 = 0.6, p2 = 0.5, power = 0.80, sig.level = 0.05)
boxplot(x, y, main = 'Boxplot of Log Streams by Group', xlab = 'Group', 
        ylab = 'Log(Streams)')
