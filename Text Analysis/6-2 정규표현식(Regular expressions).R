## 텍스트 분석 6-2 정규표현식(Regular expressions)
## 2016666 공아영 

#정규표현식이란
#특정 텍스트 문자열을 일괄적으로 찾아낼 수 있는
#패턴을 구성하는 것


#### 정규 표현식
words <- c("at", "bat", "cat", "chaenomeloses", "chase",
           "cheep","check","cheese", "chick", "hat", "ca-t")

grep("che", words, value = TRUE)
grep("a", words, value = TRUE)
grep("at", words, value = TRUE)

# "[]"
grep("[ch]", words, value = TRUE) # c혹은 h가 들어있는 문자자
grep("[at]", words, value = TRUE)
grep("[chiat]", words, value = TRUE)
grep("[chat]", words, value = TRUE)
grep("ch(e|i)ck", words, value = TRUE) # ch과 ck 사이에 e또는 i를 포함한 문자


## 수량자 ? * + 앞에 나온 패턴
# ?: 0 또는 1회
# *: 0회 이상 반복됨 (최소 0회)
# +: 1회 이상 반복됨 (최소 1회)

grep("chas?e", words, value = TRUE)
grep("chas+e", words, value = TRUE)
grep("chas*e", words, value = TRUE)

grep("ch(a*|e*)se", words, value = TRUE) #ch와 se사이에 a나 e가 0번 이상 나오는 단어


# 메타문자 ^ $
grep("^c", words, value = TRUE) #c로 시작하는 문자
grep("t$", words, value = TRUE) #t로 끝나는 문자
grep("^c.*t$", words, value = TRUE) #c로 시작하고 t로 끝나는 문자

grep("^[ch]?", words, value = TRUE) #c또는 h로 시작하거나 있어도 되고 없어도 되는 문자




#문자 클래스
words2 <- c("12 Dec", "OK", "http://", "<TITLE>Time?<TITLE>", "12345","Hi there", "5555")
words2
grep("[[:alnum:]]", words2, value = TRUE) # 알파벳이나 숫자를 포함한 문자
grep("[[:alpha:]]", words2, value = TRUE) #알파벳이 포함된 문자
grep("[[:digit:]]", words2, value = TRUE) #숫자가 포함된 문자
grep("[[:punct:]]", words2, value = TRUE) #특수문자가 포함된 문자
grep("[[:space:]]", words2, value = TRUE) #공백문자가 포함된 문자


#문자 플래스 시퀀스
grep("\\w+", words2, value = TRUE) #모든 문자열
grep("\\s+", words2, value = TRUE) #스페이스를 포함한 문자열
grep("\\d+", words2, value = TRUE) #숫자를 포함한 문자열
grep("\\D+", words2, value = TRUE) #숫자만 있는 것을 포함한 문자열






