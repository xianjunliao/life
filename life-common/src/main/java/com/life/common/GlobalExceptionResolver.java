package com.life.common;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

public class GlobalExceptionResolver extends SimpleMappingExceptionResolver {
    @Override
    protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
            Exception ex) {
        String viewName = determineViewName(ex, request);
        response.setCharacterEncoding("UTF-8");
        if (viewName != null) {// JSP格式返回
            if (!(request.getHeader("accept").contains("application/json")
                    || (request.getHeader("X-Requested-With") != null
                            && request.getHeader("X-Requested-With").contains("XMLHttpRequest")))) {
                // 如果不是异步请求
                // Apply HTTP status code for error views, if specified.
                // Only apply it if we're processing a top-level request.
                Integer statusCode = determineStatusCode(request, viewName);
                if (statusCode != null) {
                    applyStatusCodeIfPossible(request, response, statusCode);
                }

                return getModelAndView(viewName, ex, request);
            } else {// ajax请求处理
                PrintWriter printWriter = null;
                try {
                    printWriter = response.getWriter();
                    printWriter.print(ex.getMessage());
                } catch (IOException e) {
                    System.out.println(e.getMessage());
                } finally {
                    if (null != printWriter) {
                        printWriter.flush();
                        printWriter.close();
                    }
                }

                return null;
            }
        } else {
            return null;
        }
    }
}
