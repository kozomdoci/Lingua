package com.lgy.lingua.collective;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MethodCollection {
	
	// 사용자가 입력한 비밀번호를 매개변수로 전달하여 암호화된 비밀번호로 리턴
	public String passwordEncoder(String inputPassword) {
		return new BCryptPasswordEncoder().encode(inputPassword);
	}
	
	// 사용자가 입력한 비밀번호가 DB에 저장된 비밀번호와 일치하는지 여부를 리턴
	public boolean passwordMatches(String inputPassword, String dbPassword) {
		return new BCryptPasswordEncoder().matches(inputPassword, dbPassword);
	}
	
	// 인증번호 생성 메소드(매개변수: 자리수, 중복여부)
	public static String generateCode(int length, boolean isDuplicated) {
		Random rand = new Random();
		String numStr = "";
		
		for (int i=0; i<length; i++) {
			String ran = Integer.toString(rand.nextInt(10));	// 0~9까지 난수 생성
			
			if(isDuplicated) {					// 중복허용하여 난수 생성
				numStr += ran;
			}else {								// 중복제거하여 난수 생성
				if(!numStr.contains(ran)) {
					numStr += ran;					// 중복 아니면 String 에 추가
				}else {
					i -= 1;							// 중복이면 i-1 로 한번 더 반복
				}
			}
		}
		return numStr;
	}
	
	// 인증번호(or 임시비밀번호)를 생성하여 이메일로 발송하고 발송한 인증번호를 리턴
	public String sendCodeByEmail(String email) throws AddressException, MessagingException {
		
		// 메일 관련 정보
		String host = "smtp.naver.com";
		int port = 465;
		final String username = "czescimbir";
		final String password = "K6F59ZR4DHM5";
		
		// 인증번호 생성 (6자리, 중복허용)
		String codeStr = generateCode(6, true);
		
		// 메일 내용
		String subject = "신규 회원가입을 위한 이메일 인증";
		String body = "이메일 확인을 위한 인증번호 " + codeStr + "를 입력해주세요.";
		
		Properties properties = System.getProperties();
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", port);
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.ssl.enable", "true");
		properties.put("mail.smtp.ssl.trust", host);
		
		Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		session.setDebug(true);
		
		Message mimeMessage = new MimeMessage(session);
		mimeMessage.setFrom(new InternetAddress(username+"@naver.com"));
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
		mimeMessage.setSubject(subject);
		mimeMessage.setText(body);
		Transport.send(mimeMessage);
		
		return codeStr;
	}
	
}





