
--
--SELECT * 
--FROM BOARD B
--    JOIN FOOD F ON(B.FOOD_NO = F.FOOD_NO)
--    JOIN RESTAURANT R ON(B.RESTAURANT_NO = R.RESTAURANT_NO)
--WHERE B.STATUS = 'Y' AND BOARD_TYPE = 1;
--
--
--
SELECT *
FROM (SELECT ROWNUM RNUM, DESCBOARD.*
      FROM (SELECT * 
            FROM BOARD B
                JOIN FOOD F ON(B.FOOD_NO = F.FOOD_NO)
                JOIN RESTAURANT R ON(B.RESTAURANT_NO = R.RESTAURANT_NO)
                WHERE B.STATUS = 'Y' AND BOARD_TYPE = 1) DESCBOARD)
WHERE RNUM >=2 AND RNUM <=3;
--
--FROM    (SELECT 
--        BOARD_NO, BOARD_TITLE, BOARD_COUNT, FOOD_TYPE
--    FROM 
--        BOARD B
--    JOIN
--        FOOD F
--    ON
--        B.FOOD_NO = F.FOOD_NO
--    JOIN
--        RESTAURANT R
--    ON
--        B.RESTAURANT_NO = R.RESTAURANT_NO
--    ORDER BY
--        BOARD_NO DESC);






SELECT *
FROM (SELECT ROWNUM RNUM, ASCBOARD.*
      FROM (SELECT * 
            FROM BOARD B
                JOIN FOOD F ON(B.REF_FOOD_NO = F.FOOD_NO)
                JOIN RESTAURANT R ON(B.REF_RESTAURANT_NO = R.RESTAURANT_NO)
                WHERE B.STATUS = 'Y' AND BOARD_TYPE = 2
                ORDER BY B.BOARD_NO ASC ) ASCBOARD)
WHERE RNUM >=2 AND RNUM <=3;


SELECT *
FROM (SELECT ROWNUM RNUM, ASCBOARD.*
      FROM (SELECT * 
            FROM BOARD B
                JOIN FOOD F ON(B.REF_FOOD_NO = F.FOOD_NO)
                JOIN RESTAURANT R ON(B.REF_RESTAURANT_NO = R.RESTAURANT_NO)
                WHERE B.STATUS = 'Y' AND BOARD_TYPE = 2
                ORDER BY B.BOARD_NO ASC ) ASCBOARD)
WHERE RNUM BETWEEN 2 AND 3;

-----------------------------------------------
select 
from (SELECT BOARD_NO, BOARD_TYPE, BOARD_TITLE, 
                REF_RESTAURANT_NO, RESTAURANT_ADDRESS, RESTAURANT_PHONE, RESTAURANT_INTRO, RESTAURANT_CONTENT,
                REF_FOOD_NO, FOOD_NAME, FOOD_TYPE,
                REF_USER_ID, BOARD_COUNT, BOARD_CONTENT, BOARD_DATE, B.MODIFY_DATE, B.STATUS
        FROM BOARD B
            JOIN MEMBER M ON(B.REF_USER_ID = M.USER_ID)  1stAlias )
WHERE B.STATUS = 'Y' AND BOARD_NO = 2;


SELECT *
FROM (SELECT ROWNUM RNUM, ASCBOARD.*
      FROM (SELECT BOARD_NO, BOARD_TYPE, BOARD_TITLE, 
                   REF_RESTAURANT_NO, RESTAURANT_ADDRESS, RESTAURANT_PHONE, RESTAURANT_INTRO, RESTAURANT_CONTENT,
                   REF_FOOD_NO, FOOD_NAME, FOOD_TYPE,
                   REF_USER_ID, BOARD_COUNT, BOARD_CONTENT, BOARD_DATE, B.MODIFY_DATE, B.STATUS 
            FROM BOARD B
                JOIN FOOD F ON(B.REF_FOOD_NO = F.FOOD_NO)
                JOIN RESTAURANT R ON(B.REF_RESTAURANT_NO = R.RESTAURANT_NO)
                WHERE B.STATUS = 'Y' AND BOARD_TYPE = 2
                ORDER BY B.BOARD_NO ASC ) ASCBOARD)
WHERE RNUM BETWEEN 2 AND 4;

board title,  userid, board content, board date

INSERT INTO BOARD VALUES(SEQ_BID.NEXTVAL, 2, ?, 1, NULL, NULL, NULL, NULL, NULL, NULL, FOOD_TYPE, ?, DEFAULT, ?, ?, NULL, 'Y')
;
INSERT INTO BOARD VALUES(SEQ_BID.NEXTVAL, 2, '팔공', 1, 1, 'user01', DEFAULT, 'board_contetnt 중국 본토 요리', SYSDATE, NULL, 'Y');


servlet = [
MZBoard [boardNo=1, boardType=2, boardTitle=팔공, restaurantNo=8, restaurantName=쟈니덤플링, restaurantAddress=서울 용산구 보광로59길 5, restaurantPhone=02-790-8830, restaurantIntro=간단내용 : 중국 요리아시아 요리스촨, restaurantContent=상세보기 내용, foodNo=4, foodName=탕수육, foodType=중식, userId=user01, boardCount=0, boardContent=board_contetnt 중국 본토 요리, boardDate=2022-05-23, modifyDate=null, status=Y], 
MZBoard [boardNo=2, boardType=2, boardTitle=짜장면집, restaurantNo=8, restaurantName=쟈니덤플링, restaurantAddress=서울 용산구 보광로59길 5, restaurantPhone=02-790-8830, restaurantIntro=간단내용 : 중국 요리아시아 요리스촨, restaurantContent=상세보기 내용, foodNo=4, foodName=탕수육, foodType=중식, userId=user02, boardCount=0, boardContent=board_contetnt 중국 본토 요리, boardDate=2022-05-23, modifyDate=null, status=Y], 
MZBoard [boardNo=3, boardType=2, boardTitle=루비정, restaurantNo=8, restaurantName=쟈니덤플링, restaurantAddress=서울 용산구 보광로59길 5, restaurantPhone=02-790-8830, restaurantIntro=간단내용 : 중국 요리아시아 요리스촨, restaurantContent=상세보기 내용, foodNo=4, foodName=탕수육, foodType=중식, userId=user03, boardCount=0, boardContent=board_contetnt 중국 본토 요리, boardDate=2022-05-23, modifyDate=null, status=Y], 
MZBoard [boardNo=4, boardType=2, boardTitle=아라차이, restaurantNo=8, restaurantName=쟈니덤플링, restaurantAddress=서울 용산구 보광로59길 5, restaurantPhone=02-790-8830, restaurantIntro=간단내용 : 중국 요리아시아 요리스촨, restaurantContent=상세보기 내용, foodNo=2, foodName=짜장, foodType=중식, userId=user04, boardCount=0, boardContent=board_contetnt 중국 본토 요리, boardDate=2022-05-23, modifyDate=null, status=Y]

]




