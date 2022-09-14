

/*
<SELECT문의 구조>
SELECT
FROM
WHERE 
GROUP BY
HAVING
ORDER BY

<SELECT문의 구조>
SELECT : 컬럼명 AS 별칭, 계산식, 함수식       -> 조회하고자 하는 컬럼 기술
FROM : 테이블 명                           -> 컬럼이 속해 있는 테이블 기술
WHERE : WHERE 컬럼명|함수식 비교연산자 비교값 -> SELECT에 조건식 설정
GROUP BY : 그룹으로 묶을 컬럼명              -> 그룹함수가 적용될 그룹 기술
HAVING : 그룹함수식 비교연산자 비교값         -> 그룹함수에 조건식 설정
ORDER BY : 컬럼명|별칭|컬럼 순번 정렬방식 [NULLS FIRST | LAST]; -> 정렬 조건 기술
    - SELECT에서 별칭을 써두었다면, 별칭으로도 정렬 가능


<실행순서>
1)FROM : 실행해서 판을 깔고
2)WHERE : 조건 추려내고 보고 싶은 컬럼들만 취함
3)GROUP BY
4)HAVING
5)SELECT
6)ORDER BY


*/


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- ORDER BY
-- 정렬
-- 오름차순 ASC / 내림차순 DESC
--   생략 가능  /   생략 불가
-- 오름차순에서 NULL은 마지막에 배치
-- 내림차순에서 NULL은 첫 배치
-- 별칭,번호로 정렬 가능

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
-- 이름으로 오름차순(ASC)
--ORDER BY EMP_NAME ASC;
-- ASC는 생략가능. 
--ORDER BY EMP_NAME;
-- 내림차순은 생략 불가. 명시적
--ORDER BY EMP_NAME DESC;
-- NULL이 들어가 있는 값은 나중에 배치한 상태로 오름차순
--ORDER BY DEPT_CODE;
-- NULL을 먼저 배치 후 내림차순
--ORDER BY DEPT_CODE DESC;
--ORDER BY DEPT_CODE DESC NULLS FIRST;
-- 오름차순일 때는 NULL을 나중에 배치하는게 기본, 내림차순일 때는 NULL을 먼저 배치하는게 기본
ORDER BY DEPT_CODE DESC NULLS LAST;


-- 별칭으로 정렬해보자
SELECT EMP_ID, EMP_NAME, SALARY 급여, DEPT_CODE -- 급여 : 별칭
FROM EMPLOYEE
--ORDER BY SALARY;
--ORDER BY 급여;
-- 2는 EMP_NAME 대해
--ORDER BY 2 DESC;
-- 3은 SALARY에 대해 내림차순
ORDER BY 3 DESC;


-- 셀렉트가 오더바이보다 먼저 진행. 그래서 별칭을 읽어올 수 있는 것. 아래 실행순서 참조
-- ORDER BY 이외에 별칭을 읽을 수 있는게 없다. 코드 내 실행 순서 때문
-- 별칭은 컬럼이 아니라 없는 데이터를 가져올려하니 에러 : invailid identifier


/*
실행순서
1)FROM부터 실행해서 판을 깔고
2)WHERE 통해서 조건 추려내고
보고 싶은 컬럼들만 취함
3)GROUP BY
4)HAVING
5)SELECT
6)ORDER BY
*/


------------------------------------------------------------------------------
------------------------------------------------------------------------------
--------------------------------GROUP BY--------------------------------------
------------------------------------------------------------------------------


-- GROUP BY
-- 데이터들을 원하는 그룹으로 나눌 때 사용
-- 그룹함수으로 묶을 기준을 제안하는 것
-- 그룹함수가 적용될 그룹 기술


-- 부서 별 급여 합계 조회
SELECT SUM(SALARY), DEPT_CODE -- ERROR : not a single-group group function
FROM EMPLOYEE; -- 위 메세지에서의 SINGLE은 여러행 그룹은 ...?
-- 싱글과 그룹 함께 사용할 수 없다는 의미 // 결과가 하나만 나와야하는 그룹함수인데 여러행이 나오는 단일 행 함수와 혼용 불가
-- 싱글 : SUM(SALARY)
-- 그룹 : DEPT_CODE

-- 부서 별 급여 합계한다고하면 먼저 부서별로 그룹부터 나눌 것
-- 각각의 부서 그룹의 샐러리 합계 구해나아갈 것. 
-- 컴한테 어떤 것들을 그룹 지을지 알려줘야 계산할 수 있다




-- EMPYLOEE테이블에서 부서 별 급여 합계, 급여 평균, 인원 수를 조회
-- 그룹화 할 때는 그룹화의 기준이 되는 컬럼은 가능해보임
SELECT DEPT_CODE, SUM(SALARY), AVG(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 그룹지어지는 대상과 일반함수와 같아야한다. 
-- GROUP BY에 넣을 컬럼명과 SELECT 오른쪽 컬럼명이 같아야함


-- EMPLOYEE테이블에서 부서코드와 보너스 받는 사원수 조회
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


-- IS NOT NULL 사용
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
-- 결과에 어떤 영향이? 
-- D2부서에서 보너스 받는 사람이 없는데 이게 안나옴




--WHERE BONUS IS NOT NULL -- WHERE절이 없으면 COUNT(*)는 사람수를 카운트함

--EMPLOYEE테이블에서 직급코드, 보너스를 받는 사원수 조회
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE;
-- 보너스 안받는 사람을 안보고 싶다면, WHERE BONUS IS NOT NULL 추가 







--EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리(보통 내림하라는 의미)), 급여합계, 인원 수 조회(인원수로 내림차순)
SELECT FLOOR(AVG(SALARY)),SUM(SALARY), COUNT(*), 
        DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여') -- SELECT문 첫번째로 GROUP BY 기준점이랑 안나와도 되는듯
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);


SELECT FLOOR(AVG(SALARY)),SUM(SALARY), COUNT(*),
        CASE WHEN SUBSTR(EMP_NO,8,1) = 1 THEN '남'
             WHEN SUBSTR(EMP_NO,8,1) = 2 THEN '여'
            -- ELSE '여'
        END 성별
FROM employee
GROUP BY SUBSTR(EMP_NO,8,1);

---RE
SELECT FLOOR(AVG(SALARY)),SUM(SALARY), COUNT(*),
        DECODE(SUBSTR(EMP_NO,8,1),1,'남','여')
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1)
ORDER BY COUNT(*) DESC;


--EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리(보통 내림하라는 의미)), 급여합계, 인원 수 조회(인원수로 내림차순)
-- 데이터에 직접적으로 없는 데이터를 GROUP BY해서 평균,합계,수 조회해야함
-- CASE WHEN
SELECT FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) ,
        CASE WHEN SUBSTR(EMP_NO,8,1)=1 THEN '남'
             WHEN SUBSTR(EMP_NO,8,1)=2 THEN '여'
        END "성별"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1)
ORDER BY COUNT(*) DESC;

-- DECODE
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'남','여')성별, FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1)
ORDER BY COUNT(*) DESC;


-- EMPLOYEE테이블에서 부서 코드별로 같은 직급인 사원의 급여 합계 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE 
GROUP BY DEPT_CODE, JOB_CODE;

-- EMPLOYEE테이블에서 부서 코드별로 같은 직급인 사원의 급여 합계 조회
-- 부서별, 동 직급별 2개의 그룹핑 필요
-- 모범 답안
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE;



------------------------------------------------------------------------------
------------------------------------HAVING------------------------------------
------------------------------------------------------------------------------

-- HAVING
-- 조건절
-- 비슷 = WHERE
-- 차이 WHERE 대상 일반 컬럼
--     HAVING 대상 GROUP BY의 데이터


-- 1)부서 코드와 급여 3000000이상인 직원의 그룹 별 평균 급여 조회
-- 2)부서 코드와 급여 평균 3000000이상인 그룹 별 평균급여 조회

-- 1)부서 코드와 급여 3000000이상인 직원의 그룹 별 평균 급여 조회
-- 모범 답안

SELECT DEPT_CODE,AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;


-- 2)부서 코드와 급여 평균 3000000이상인 그룹 별 평균급여 조회

SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 300000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;


-- 부서 별 급여 합계 중 900000을 초과하는 부서코드와 급여 합계 조회
-- 모범 답안


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 900000
ORDER BY DEPT_CODE;

------------------------------------------------------------------------------
----------------------------------다시풀어보기----------------------------------

--EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리(보통 내림하라는 의미)), 급여합계, 인원 수 조회(인원수로 내림차순)
-- 데이터에 직접적으로 없는 데이터를 GROUP BY해서 평균,합계,수 조회해야함

SELECT FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*),
        DECODE(SUBSTR(EMP_NO,8,1),1,'남','여')
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1)
ORDER BY COUNT(*) DESC; 

SELECT FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*),
        CASE WHEN SUBSTR(EMP_NO,8,1)=1 THEN '남'
             ELSE '여'
        END 성별
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1)
ORDER BY COUNT(*) DESC; 

-- EMPLOYEE테이블에서 부서 코드별로 같은 직급인 사원의 급여 합계 조회
-- 부서별, 동 직급별 2개의 그룹핑 필요

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;


-- 1)부서 코드와 급여 3000000이상인 직원의 그룹 별 평균 급여 조회
-- 2)부서 코드와 급여 평균 3000000이상인 그룹 별 평균급여 조회

SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, SALARY
HAVING SALARY >= 3000000;

-- 2)부서 코드와 급여 평균 3000000이상인 그룹 별 평균급여 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;


---RE
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- 부서 별 급여 합계 중 900000을 초과하는 부서코드와 급여 합계 조회

SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 900000
ORDER BY DEPT_CODE;


---RE
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 900000;

------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- ROLLUP, CUBE
-- 집계 함수 : 그룹별 산출한 결과물을 집계하는 함수
-- 집계 함수를 쓴다는건 산출한 결과물들을 가지고 집계해주는거 맞구나 생각드는데 근데
--
-- 롤업 큐브 차이점
-- 롤업은 인자로 전달받은 것 중 첫번째 한번만 집계
-- 큐브는 인자로 지정된 모든 것들에 대해 중간 집계
--      ex)ROLLUP : GROUP BY로 그루핑된 첫그룹의 종류별로 합계 반환
--      ex)CUBE : GROUP BY로 그루핑된 첫그룹의 종류별로 합계 반환한 후, 두번째 그룹의 합계 또 반환

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
--GROUP BY JOB_CODE           -- 각 직급 코드별 합계 7행
--GROUP BY ROLLUP(JOB_CODE) -- 롤업이나 큐브코드 추가시 행이 하나 더 생김. 마지막행의 데이터는 총합
GROUP BY CUBE(JOB_CODE) --
ORDER BY JOB_CODE;


--EMPLOYEE테이블에서 각 부서코드마다 직급코드 별 급여 합, 부서 별 급여 합, 총합 조회
SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE 
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;


---RE
SELECT DEPT_CODE, JOB_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- ROLLUP
SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP (DEPT_CODE, JOB_CODE);

-- CUBE
-- 그룹별 산출한 결과를 집계하는 함수
-- 롤업은 인자로 전달받은 것 중 첫번째 한번만 집계
-- 큐브는 인자로 지정된 모든 것들에 대해 중간 집계



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------SET OPERATION----------------------------------
------------------------------------------------------------------------------


-- SET OPERATION : 집합 연산자
-- 두 개 이상의 테이블에서 조인을 사용하지 않고 연관된 데이터를 조회하는 방법

-- 종류
-- UNION : 합집합 OR조건
-- INTERSECT : 교집합 AND조건
-- MINUS : 차집합 A-B
-- 쿼리의 결과와 쿼리의 결과를 하나로 합쳐 해당 함수의 적용, 결과를 반환

-- 합집합 A OR B
-- 교집합 A AND B 공통분모
-- 차집합 A - B
-- 여집합 A B를 제외한 나머지

-- UNION : 합집합 OR조건
-- INTERSECT : 교집합 AND조건
-- MINUS : 차집합 A-B
-- UNION ALL : AND조건 + OR조건(중복된 행 추가조회)
-- 

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- UNION : 합집합
-- 두 쿼리를 결과를 하나로 합쳐 AND조건으로 반환
-- 왜 사용? WHERE절에 조건을 다 쓰거나 OR로 처리하기 힘들 경우
-- UNION 미적용
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200; -- 선동일
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201; -- 송종기
-- UNION 적용
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200 
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201; -- 선동일 송종기
--같은방법
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200  OR EMP_ID = 201;


-- EMPLOYEE테이블에서 DEPT_CODE가 D5이거나 급여가 300000을 초과하는 
-- 직원의 사번, 이름, 부서코드, 급여조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY = 300000;
-- UNION 적용
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = 300000;


------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- INTERSECT : 교집합
-- 쿼리의 결과와 쿼리의 결과를 하나로 합쳐 OR조건 적용, 결과를 반환
-- INTERSECT 사용
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = 300000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 300000;
--집합연산자에서 SELECT 절은 동일해야 되고 FROM절은 달라도 대나요?
-- 가능


------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- MINUS : 차집합

-- DEPT코드가 D5이면서 연봉이 3000000초과인 사람을 도출하는 코드

-- UNINON ALL
-- 



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------






















------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------









