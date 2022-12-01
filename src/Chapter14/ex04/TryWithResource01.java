package Chapter14.ex04;

import java.io.IOException;
import java.io.InputStreamReader;

public class TryWithResource01 {

	public static void main(String[] args) {
		// Try 구문에서 리소스 자동해제 , 객체를 사용후에 반드시 그 객체를 제거(close())해서 메모리를 최적화
		//	객체를 사용후 finally 블락에서 객체를 제거함.
		
		System.out.println("문자를 입력하세요! >>>");
		
		//1. 리소스 수동 해제 : finally 블락에서 객체를 close() 메소드를 호출해서 객체를 메모리에서 제거
		
		//콘솔을 사용해서 문자열을 입력 받도록 하는 클래스 : InputStreamReader
		InputStreamReader ir1 = null;	//객체선언 (하면 종료시켜야함)
		
		//일반예외 (catched Exception)	: 프로그램 작성시 컴파일 단계에서 오류
		   //반드시 예외를 처리해야한다.
			// 1. 예외를 남에게 전가	: throws 를 사용해서 호출하는 쪽에서 처리하도록 미루는 방법
				//메소드 블락에서 적용됨 , 메소드를 호출하는 곳에서 예외 처리를 해야함
			// 2. 예외를 내가 처리	: try - catch 블락을 만들어서 내가 처리
		
		ir1 = new InputStreamReader(System.in);	
		//예외를 내가 처리
		try {		//IOException 발생
			char input = (char) ir1.read();		//예외처리가 되어야함. 일반예외 : IOException
			System.out.println("입력한 글자는 : " + input);
			
		} catch (IOException e) {
			//
			System.out.println("IOException 이 발생되었습니다. 하나의 문자만 넣어 주세요.");
			e.printStackTrace();	//오류에 대한 자세한 정보 출력
			//예외전가 :ir1.read();에 마우스를 올리고1.은 전가,2.는내가처리 
		}finally {
			//일반적으로 객체를 사용후 finally 블락에서 객체를 제거함.
				//객체를 제거할때도 예외처리가 되어야한다.
			if (ir1 != null) {	//객체가 null일 경우는 제거하지 않고 null이 아닐때 제거함.
				try {
					ir1.close();	//일반예외 : 반드시 예외 처리를 해야한다.
				} catch (IOException e) {
					System.out.println("객체 제거시 예외 발생됨");
					e.printStackTrace();
				}
			}
		}	//자동종료 TryWithResource02
		
		
		
		
		
		
		
		
		
		
	}

}
