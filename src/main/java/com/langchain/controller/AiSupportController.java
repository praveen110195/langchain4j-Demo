package com.langchain.controller;

import com.langchain.service.JavaLangChainAIAgent;
import com.langchain.service.OrderSupportAIAgent;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/ai-support")
public class AiSupportController {

    private JavaLangChainAIAgent agent;

    private OrderSupportAIAgent orderSupportAIAgent;

    public AiSupportController(
            JavaLangChainAIAgent agent,
            OrderSupportAIAgent orderSupportAIAgent) {
        this.agent = agent;
        this.orderSupportAIAgent = orderSupportAIAgent;
    }

    @GetMapping
    public String chat(
            @RequestParam String message) {
        return agent.chat(message);
    }

    @GetMapping("/order")
    public String orderSupport(
            @RequestParam String message) {
        return orderSupportAIAgent.chat(message);
    }

}
