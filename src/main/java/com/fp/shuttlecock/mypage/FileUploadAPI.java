package com.fp.shuttlecock.mypage;

import java.io.ByteArrayInputStream;
import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.fp.shuttlecock.user.UserDTO;

import jakarta.servlet.http.HttpSession;

//https://guide.ncloud-docs.com/docs/storage-storage-8-1
@Component
@PropertySource("classpath:application.properties")
public class FileUploadAPI {
	
	@Autowired
	MypageServiceImpl service;
	
	@Value("${NCP.STORAGE.ACCESSKEY}")
	private String accessKey; //api 인증키 > Access Key ID
	@Value("${NCP.STORAGE.SECRETKEY}")
	private  String secretKey; //api 인증키 > Secret Key
	
	
	public void ncpFileupload(HttpSession session) {
		String userId = session.getAttribute("userId").toString();

		UserDTO user = null;
		user = service.getMypage(userId); 
		
		String endPoint = "https://kr.object.ncloudstorage.com";
		String regionName = "kr-standard";
		
		System.out.println("accessKey : " + accessKey);
		System.out.println("secretKey : " + secretKey);
		// S3 client
		AmazonS3 s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();

		String bucketName = "team1bucket"; //버킷 이름 : backend19

		// create folder
		String folderName = "profile/"; //upload 폴더,경로 지정 : profile/

		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(0L);
		objectMetadata.setContentType("application/x-directory");
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, folderName,
				new ByteArrayInputStream(new byte[0]), objectMetadata);
		


		try {
			s3.putObject(putObjectRequest);
			System.out.format("Folder %s has been created.\n", folderName);
		} catch (AmazonS3Exception e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		}

		// upload local file
		String objectName = folderName + user.getUserImageName(); //upload폴더/생성할파일이름.확장자
		String filePath = user.getUserImagePath() + "\\" + user.getUserImageName(); //실제 local에서 올릴 파일 경로 및 파일이름
		System.out.println("objectName :" + objectName);
		System.out.println("filePath : " + filePath);
		
		try {
			//s3.putObject(bucketName, objectName, new File(filePath)); //기본 비공개로 생성
			
			s3.putObject(new PutObjectRequest(bucketName, objectName, new File(filePath)) //PutObjectRequest 객체 생성 -> Public(공개) 생성
		            .withCannedAcl(CannedAccessControlList.PublicRead));
			
			System.out.format("Object %s has been created.\n", objectName);
		} catch (AmazonS3Exception e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		}

	}

}
