library(ggplot2)
library(sqldf)
library(RColorBrewer)
library(dplyr)
library(lubridate)

file=choose.files() #demo
customer <- read.table(file, header=T, sep=",") 
file1 = choose.files() #구매내역정보
purchaseList <- read.table(file1, header=T, sep=",")

tb <- sqldf("select a.id, a.성별, a.연령, b.거래일자, b.상품대분류명, 
            b.상품중분류명, b.구매건수, b.거래식별ID, b.구매금액, b.점포ID
            from customer as a,
            purchaseList as b where a.id = b.id")

tb$거래일자 <- ymd(tb$거래일자)
tb$거래월 <- month(tb$거래일자)
tb$구매금액 <- as.numeric(tb$구매금액)
tb$구매건수 <- as.numeric(tb$구매건수)

head(tb)

tb2 <- subset(tb, 거래월!=10)

head(tb2)

s1 <- tb2 %>%
  group_by(거래월, 상품대분류명, 점포ID) %>%
  summarise(amount = sum(round(구매금액/1000,0)), cnt = sum(구매건수))


with(s1, boxplot(amount~점포ID))
with(s1, boxplot(amount~거래월))
with(s1, boxplot(cnt~점포ID))
with(s1, boxplot(cnt~거래월))

s1

g <- ggplot(s1, aes(점포ID, amount,  fill = 점포ID))

g + geom_violin() + 
  labs(title="Box plot", 
       subtitle="점포별 매출",
       caption="Source: LotteData",
       x="점포ID",
       y="amount") +
  theme_bw() +
  stat_summary(fun.y=median, geom="point", size=2, color="red")
#+ geom_jitter(shape=16, position=position_jitter(0.2))
