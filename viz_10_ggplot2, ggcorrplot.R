## 시각화 패키지: ggplot2, ggcorrplot


if(!require(ggplot2)){
  install.packages("ggplot2")
  require(ggplot2)
}

data(mpg, package="ggplot2")
mpg$manufacturer
table(mpg$manufacturer)


## audi, ford, hyundai, toyota만 추출
mpg_select <- mpg[mpg$manufacturer %in% c("audi", "ford", "hyundai", "toyoa")]



# bubble chart 차트 
g <- ggplot(mpg_select, aes(x=displ, y=cty)) + 
  geom_point(aes(col=manufacturer, size=hwy)) +
  labs(title="Bubble Chart", subtitle="mpg : 배기량 vs 도시연비",
       x = "배기량", y="도시연비")
g

graphics.off()


##### Corrleogram #################
if(!require(ggcorrplot)){
  install.packages("ggcorrplot")
  library(ggcorrplot)
}

data1<- subset(mpg, select=c(displ,cty,hwy,cyl))
corr <- round(cor(data1), 3) #선형상관계수



# Plot
ggcorrplot(corr, hc.order = TRUE, 
           type = "upper", 
           lab = TRUE,# 상관계수를 표시
           lab_size = 5, #글자 크기
           method="circle", 
           colors = c("tomato2", "white", "springgreen3"), 
           title="Correlogram of mcar", 
           ggtheme=theme_bw)

data(mpg, package="ggplot2")

