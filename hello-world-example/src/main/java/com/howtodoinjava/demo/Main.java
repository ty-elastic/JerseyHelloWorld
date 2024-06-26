package com.howtodoinjava.demo;

import org.glassfish.grizzly.http.server.HttpServer;
import org.glassfish.jersey.grizzly2.httpserver.GrizzlyHttpServerFactory;
import org.glassfish.jersey.server.ResourceConfig;

import jakarta.ws.rs.ApplicationPath;

import java.net.URI;

@ApplicationPath("/")
public class Main extends ResourceConfig {

  public static final String BASE_URI = "http://0.0.0.0:8080/";

  public Main() {
    packages("com.howtodoinjava.demo.web");
  }

  public static void main(String[] args) {
    startServer();
  }

  public static HttpServer startServer() {

    final HttpServer server =
      GrizzlyHttpServerFactory.createHttpServer(URI.create(BASE_URI), new Main());
    System.out.println("Jersey application started at " + BASE_URI);
    System.out.println("Press Ctrl+C to stop the server.");
    return server;
  }
}
