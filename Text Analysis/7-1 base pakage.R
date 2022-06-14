## 텍스트 분석 7-1 base pakage

string <- c("data analysis is useful",
            "business anlytics is helpful",
            "visualization of data is interesting ofr data scientists")
string

grep("data", string) #data 인덱스 찾기
grep("data", string, value=TRUE) #data가 들어있는 인덱스 값 찾기

string[grep("data", string)]

grepl("data", string) #논리값 반환


## regexpr(), gregxpr(): 패턴위치
regexpr(pattern = "data", text = string) #패턴위치, 시작위치

gregexpr("data", string) #리스트형태로 반환

### regmatches(): 패턴추출
?regmatches()
regmatches(x=string, m=regexpr(pattern = "data", text = string)) #첫번째값만
regmatches(x=string, m=gregexpr(pattern = "data", text = string))

regmatches(string, regexpr("data", string), invert=TRUE) #특정단어제외
regmatches(string, gregexpr("data", string), invert=TRUE) #특정단어 제외

#sub(), gsub() 문자를 치환하는 경우 g~모두 치환
?sub()
sub("data", replacement = "text",string) #첫 번째만
gsub("data", replacement = "text",string) #모든 문자


## strsplit()
string
strsplit(string, " ") #공백을 기준으로 분할. 리스트로반환
unlist(strsplit(string, " ")) #벡터로 반환하기
unique(unlist(strsplit(string, " "))) #단어 중복 제외

gsub("is|of|for", replacement = "",string) #특정 단어 없애기
gsub("is|of|for", replacement = "",unique(unlist(strsplit(string, " "))) #단어 중복 제외
) 


string <- c("date analysis is useful",
            "business anlytics is helpful",
            "visualization of data is interesting ofr data scientists")

sub("date", "data",unique(unlist(strsplit(string, " "))))

      