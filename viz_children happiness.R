#viz children happiness

#현재행복정도및행복하지않은이유

library(dplyr)
library(stringr)
library(ggplot2)
library(ggrepel)
library(RColorBrewer)

Happiness <- read.csv("data/현재_행복_정도_및_행복하지_않은_이유_2021.csv", header=T)
str(Happiness)
head(Happiness)
colnames(Happiness)
str(Happiness)

Happiness <- Happiness[-1,]
#Happiness <- data.frame(t(Happiness))
#new <- gsub('X', '', names(Happiness))

#Happiness <- Happiness %>% rename_at(vars(as.character(names(Happiness))), ~ as.character(new))

Happiness21 <- Happiness %>% rename_at(vars(as.character(names(Happiness))), ~ as.character(Happiness[1,]))
Happiness21 <- data.frame(Happiness21[-1,])
new <- gsub('[.]', '', names(Happiness21))
Happiness21 <- Happiness21 %>% rename_at(vars(as.character(names(Happiness21))), ~ as.character(new))
rownames(Happiness21) = NULL
H_index21 <- Happiness21[,c(1:6)] #행복지수
H_index21$전혀행복하지않다 <- as.integer(H_index21$전혀행복하지않다)
H_index21$행복하지않은편이다 <- as.integer(H_index21$행복하지않은편이다)
H_index21$행복한편이다 <- as.integer(H_index21$행복한편이다)
H_index21$매우행복하다 <- as.integer(H_index21$매우행복하다)

H_index21$not_h <- H_index21$전혀행복하지않다 + H_index21$행복하지않은편이다 #행복하지않은 정도합
H_index21$yes_h <- H_index21$행복한편이다 + H_index21$매우행복하다 #행복한 정도합

str(H_index21)

g1 <- H_index21 %>% filter(!응답자유형별1 == '전체') %>%
  group_by(응답자유형별1, 응답자유형별2) %>%
  summarise(not_h = sum(not_h), yes_h = sum(yes_h))
g1 #유형별 행복정도합

str(g1)


#유형별 행복하지않은 정도

(g <- ggplot(g1, aes(응답자유형별1, not_h)) +
    geom_col(aes(fill = 응답자유형별2), position = position_stack(reverse = TRUE)) +
    theme(legend.position = 'none'))

ggplot(g1, aes(응답자유형별1, not_h)) + geom_point()+ 
  geom_text(aes(label=응답자유형별2), nudge_y=0.8, size=4, check_overlap = T)


(g2 <- ggplot(g1, aes(응답자유형별1, not_h)) +
    geom_point(aes(col = 응답자유형별2, size = yes_h)) +
    labs(title = "유형별 행복하지 않은 아동청소년 vs 행복한 아동청소년",
         x = "유형", y = "응답수"))

g2 + geom_text(aes(label=응답자유형별2),  nudge_x=0.2, size=3,check_overlap = T)


# 우리나라 아동, 청소년의 행복정도



Happiness2 <- read.csv("data/현재_행복_정도_및_행복하지_않은_이유19-21.csv", header=T)
str(Happiness2)
head(Happiness2)
colnames(Happiness2)

new <- gsub('X', '', names(Happiness2))
Happiness2 <- Happiness2 %>% rename_at(vars(as.character(names(Happiness2))), ~ as.character(new))
new <- gsub('[.]', '', names(Happiness2))
Happiness2 <- Happiness2 %>% rename_at(vars(as.character(names(Happiness2))), ~ as.character(new))

Happiness2 <- Happiness2 %>% filter(현황별1 == '행복하지 않은 이유별', 응답자유형별1 == '전체') %>%
  select(현황별2, 시점, 데이터) %>%
  group_by(시점)

Happiness2$시점 <- as.character(Happiness2$시점)
str(Happiness2)

g <- ggplot(data=Happiness2, aes(x=현황별2, y=데이터, group=시점, color = 시점)) +
  geom_line()+
  geom_point()

g

# 인권존중정도


Respect <- read.csv("data/자신의_인권_존중_정도_2021.csv", header=T)
head(Respect)
colnames(Respect)
str(Respect)

Respect21 <- Respect %>% rename_at(vars(as.character(names(Respect))), ~ as.character(Respect[1,]))
Respect21 <- data.frame(Respect21[-1,])
new2 <- gsub('[.]', '', names(Respect21))
Respect21 <- Respect21 %>% rename_at(vars(as.character(names(Respect21))), ~ as.character(new2))
rownames(Respect21) = NULL

Respect21$전혀존중받지못한다 <- as.integer(Respect21$전혀존중받지못한다)
Respect21$존중받지못하는편이다 <- as.integer(Respect21$존중받지못하는편이다)
Respect21$존중받는편이다 <- as.integer(Respect21$존중받는편이다)
Respect21$매우존중받는다 <- as.integer(Respect21$매우존중받는다)

Respect21$not_r <- Respect21$전혀존중받지못한다 + Respect21$존중받지못하는편이다 #존중합
Respect21$yes_r <- Respect21$존중받는편이다 + Respect21$매우존중받는다

str(Respect21)

# 가족유형별 존중정도
g2 <- Respect21 %>%
  filter(응답자유형별1 == '가족유형') %>%
  group_by(응답자유형별2) %>%
  summarise(not_r=sum(not_r))

str(g2)

(g <- ggplot(g2, aes(응답자유형별2, not_r)) +
    geom_col(aes(fill = 응답자유형별2), position = position_stack(reverse = TRUE)))



g3 <- Respect21 %>%
  group_by(응답자유형별1,응답자유형별2) %>%
  summarise(not_r = sum(not_r), yes_r = sum(yes_r))

str(g3)

# 유형별 행복정도와 인권존중 정도
test <- H_index21[,-c(3:6)] %>% inner_join(g3)
str(test)

(g <- ggplot(test, aes(x=응답자유형별1, y=응답자유형별2)) + 
    geom_point(aes(not_h, size=not_r)))

(g2 <- ggplot(test, aes(응답자유형별1, not_h)) +
    geom_point(aes(col = 응답자유형별2, size = not_r)) +
    labs(title = "Bubble Chart", subtitle = "유형별 행복지수와 존중정도",
         x = "응답자유형1", y = "행복하지않은지수"))

g2 + geom_text_repel(aes(label=응답자유형별2), size=3,check_overlap = T)
g2



