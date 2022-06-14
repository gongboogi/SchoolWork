## 텍스트 분석 6-1 텍스트 전처리 복습 

p1 <- "You come at four in the afternoon, then at three I shall bebine to be happy"
p2 <- "One runs the irst of weeping a litter, if one lets himeslf be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"

littleprice <- c(p1, p2, p3)
strsplit(littleprice, split = " ")


fox.said <- "what IS ESSENTIAL is invisible to the Eye"
fox.said
unlist(strsplit(fox.said, split = " "))
fox.said.words <- strsplit(fox.said, split = " ")[[1]]
fox.said.words
unique(fox.said.words) #대문자 소문자를 구분
unique(tolower(fox.said.words))

paste(fox.said.words)
heroes <- c("Batman","Captin", "Hulk", "MinHo")
colores <- c("Black", "Blue", "Red")

paste(fox.said.words, collapse = " ")
paste(fox.said.words, collapse = "!!")

paste(month.abb, 1:12)
paste(month.abb, 1:12, sep = ":")
paste(month.abb, 1:12, sep = "-", collapse = " ")


#문자의 쌍을 만들어 곱할 수 있다다
contries <- c("KOR", "US", "EU")
stat <- c("GDP", "Pop", "Area")
outer(contries, stat)
outer(contries, stat, FUN = paste, sep = "-")

customer <- c("Ryu", "Kim", "Choi")
buysize <- c(10,8,9)
deliveryday <- c(2,3,7.5)
sprintf("hello %s, your order of %s product(s) will be deliverd within %s", customer, buysize, deliveryday)

substring("Text Anlytics", 6)
substring("Text Anlytics", 3)
class <- c("Data analytics", "Data visualization", "Data science introduction")
substr(class, 1, 4) #1부터 4까지

countries <- c("Korea, KR", "United states, US", "China, CN")
nchar(countries)
substring(countries, nchar(countries)-1)
substr(countries, nchar(countries)-1, nchar(countries))


landnames <- names(islands)

index <- grep(pattern = "New", x = landnames)
grep(pattern = "New", x=landnames, value= TRUE)


# 텍스트의 치환
sub()
gsub()

txt <- "Data Analytics is useful. Data Analytics is also interesting"
sub(pattern = "Data", replacement = "Business", x = txt)
# -> 첫 번째 문장에 대해서만 적용된다. 전체 문장에서 바꾸고 싶을 때?
gsub(pattern = "Data", replacement = "Business", x = txt)
#gsub를 이용하면 전체 문자에 대해서 변경 가능하다.


# 파일명만 가지고 싶을 때
txt2 <- c("product.csv", "order.csv", "customer.csv")
gsub(pattern = ".csv","", txt2)
