/* 회원 정보를 저장하는 테이블 */

Create Table myTbl(
	idx number not null,
	id varchar2(100) not null,		-- 행의 번호 : 1씩 증가
	pass varchar2(100) not null,	-- 회원의 ID
	name varchar2(100) not null,	-- 회원의 password정보를 저장
	email varchar2(100) not null,	-- 회원의 이름을 저장하는 컬럼
	city varchar2(100) null,		
	phone varchar2(100) null
);

alter table mㅛTbl
add constraint mbTbl_id_px primary key (id);
/*
	01 : Statement	, 02 : PreparedStatement
	insert01.jsp	: 사용자 정보를 입력
	save01.jsp		: 사용자 정보를 저장
	list01.jsp		: 사용자 정보를 출력
	read01.jsp		: 사용자 정보를 출력
	delete01.jsp	: 사용자 정보를 삭제
	update01.jsp	: 사용자 정보를 수정

*/
