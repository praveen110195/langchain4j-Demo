package com.langchain.service;


import dev.langchain4j.service.spring.AiService;

@AiService
public interface JavaLangChainAIAgent {

    String chat(String message);
}