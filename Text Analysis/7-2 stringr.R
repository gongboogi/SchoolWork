## 텍스트 분석 7-2 stringr()

### String 패키지: 직관적임. 인자가 동일함
install.packages("stringr")
library(stringr)
string <- c("data analysis is useful",
            "business anlytics is helpful",
            "visualization of data is interesting ofr data scientists")


# str_detect(): 패턴검출
# -> grepl()과 동일한 기능
str_detect(string, pattern = "data") #데이터가 들어있는가?
str_detect(string, "DATA") #대소문자 구분함
str_detect(string, fixed("DATA", ignore_case = TRUE)) #ignore_case: 무시

str_detect(c("aby", "acy", "a.y"), "a.y") #.은 모든 문자열이됨
str_detect(c("aby", "acy", "a.y"),fixed("a.y")) #fixed로 문자 그대로
str_detect(c("aby", "acy", "a.y"), "a\\.y") #이스케이프문자 활용



# str_locate(), str_loacte_all(): 패턴위치
str_locate(string, "data")
str_locate_all(string, "data")


# str_extract(): 문자열 추출
# -> regmatches()
str_extract(string, "data")
str_extract_all(string, "data")

str_extract_all(string,"data", simplify = TRUE) #벡터로

unlist(str_extract_all(string,"data"))
  
sentences5 <- sentences[1:5]

str_extract(sentences5, "(a|A|the|THE) (\\w+)") #단어를 결합해서
str_match(sentences5, "(a|A|the|THE) (\\w+)") #각각의 그룹 단어를 나눠줌

str_match_all(sentences5, "(a|A|the|THE) (\\w+)")



# str_replace(), str_replace_all(): 패턴추출. 치환
str_replace(string,"data","text") #첫 번째 데이터만
str_replace_all(string, "data","text")


# str_split(): 패턴분할
str_split(string, " ")
str_split(sentences5, " ")
unlist(str_split(string, " "))
unique(unlist(str_split(string, " "))) #중복제거


str_split(sentences5, " ", n=5) #반환받을 문자 개수 정하기
str_split(sentences5, " ", n=3, simplify = TRUE)


# 추가 기능
str_length(string) #문자 길이

str_count(string, "data") #단어 개수
str_count(string, "\\w+") #\\w+모든 단어 개수

mon <- 1:12
str_pad(mon, width = 2, side="left", pad="0") #문자 채우기


string_pad <- str_pad(string, max(str_length(string)), "both", " ")
str_trim(string_pad, side = "both") #공백제거
