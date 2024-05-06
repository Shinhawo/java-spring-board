package kr.co.won.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication auth) throws IOException, ServletException {

        List<String> roleNames = new ArrayList<>();

        auth.getAuthorities().forEach(authority -> {
            roleNames.add(authority.getAuthority());
        });

        if (roleNames.contains("ROLE_ADMIN") || roleNames.contains("ROLE_MEMBER")) {
            // ROLE_ADMIN 또는 ROLE_MEMBER 권한이 있을 때는 /main으로 리다이렉트
            response.sendRedirect("/main");
        } else {
            // 그 외의 경우는 홈페이지로 리다이렉트
            response.sendRedirect("/");
        }
    }
}
