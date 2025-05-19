package com.module.gym.infrastructure.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

import org.springframework.http.*;
import org.springframework.security.authentication.*;
import org.springframework.security.core.*;
import org.springframework.security.core.context.*;
import org.springframework.stereotype.*;
import org.springframework.web.filter.*;

import com.google.firebase.auth.*;

@Component
public class FirebaseFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
        throws ServletException, IOException {

        String authHeader = request.getHeader("Authorization");

        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String idToken = authHeader.substring(7);

            try {
                var decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);
                List<GrantedAuthority> authorities = List.of();
                var authentication = new UsernamePasswordAuthenticationToken(
                    decodedToken,
                    null,
                    authorities
                );
                SecurityContextHolder.getContext().setAuthentication(authentication);
            } catch (FirebaseAuthException e) {
                response.setStatus(HttpStatus.UNAUTHORIZED.value());
                response.getWriter().write("Invalid Firebase ID token");
                return;
            }
        }

        filterChain.doFilter(request, response);
    }
}
