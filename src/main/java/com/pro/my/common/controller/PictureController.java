package com.pro.my.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/picture")
public class PictureController {

    private static final String CURR_IMAGE_PATH = "resources/files";

    @Autowired
    private ServletContext servletContext;

    // 파일 업로드
    @PostMapping("/upload")
    public void uploadPicture(MultipartFile file, HttpServletResponse res) {
        try {
            String prifix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
            String realName = UUID.randomUUID().toString() + "." + prifix;
            
            // ServletContext를 사용하여 절대 경로 얻기
            String absolutePath = servletContext.getRealPath("/");
            String fullPath = absolutePath + CURR_IMAGE_PATH + File.separator + realName;

            // 파일을 서버에 저장할 폴더 경로 생성
            File directory = new File(absolutePath + CURR_IMAGE_PATH);
            if (!directory.exists()) {
                directory.mkdirs(); // 폴더가 없으면 폴더 생성
            }

            // 파일을 서버에 저장
            File dest = new File(fullPath);
            try (InputStream is = file.getInputStream(); OutputStream os = new FileOutputStream(dest)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
            }

            // 파일 저장 후 경로를 클라이언트에 반환
            String fileUrl = servletContext.getContextPath() + "/picture/get?imageFileName=" + realName;
            res.setContentType("text/plain");
            res.getWriter().write(fileUrl);  // 클라이언트에게 URL을 반환
            res.getWriter().flush();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 업로드된 파일을 반환
    @GetMapping("/get")
    public void getPicture(@RequestParam String imageFileName, HttpServletResponse response) throws IOException {
        // 파일의 절대 경로
        String fullPath = servletContext.getRealPath("/") + CURR_IMAGE_PATH + File.separator + imageFileName;
        File file = new File(fullPath);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "file not found");
            return;
        }

        // 파일 확장자를 이용하여 MIME 타입 설정
        String fileExtension = getFileExtension(imageFileName);
        String mimeType = getMimeType(fileExtension);

        // MIME 타입을 설정
        response.setContentType(mimeType);
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Content-Disposition", "inline; filename=" + imageFileName); // 'inline'으로 설정하면 브라우저에서 바로 표시

        try (InputStream in = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int count;
            while ((count = in.read(buffer)) != -1) {
                out.write(buffer, 0, count);
            }
        }
    }

    // 파일 확장자를 얻는 유틸리티 메서드
    private String getFileExtension(String fileName) {
        if (fileName == null || fileName.lastIndexOf(".") == -1) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
    }

    // 확장자에 따른 MIME 타입 반환
    private String getMimeType(String fileExtension) {
        switch (fileExtension) {
            case "png":
                return "image/png";
            case "jpg":
            case "jpeg":
                return "image/jpeg";
            case "gif":
                return "image/gif";
            case "bmp":
                return "image/bmp";
            case "svg":
                return "image/svg+xml";
            default:
                return "application/octet-stream"; // 알 수 없는 확장자의 경우
        }
    }
}
