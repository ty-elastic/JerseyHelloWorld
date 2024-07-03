package com.howtodoinjava.demo.web;

import com.howtodoinjava.demo.web.model.Item;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.NewCookie;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("items")
public class MyResource {

  public int foo() {
    try {
      Thread.sleep(50);
    } catch (InterruptedException e) {
    }

    double d = Math.tan(Math
        .atan(Math.tan(Math.atan(Math.tan(Math.atan(Math.tan(Math.atan(Math.tan(Math.atan(123456789.123456789))))))))));

    bar();
    return 0;
  }

  public int bar() {
    try {
      Thread.sleep(50);
    } catch (InterruptedException e) {
    }

    double d = Math.tan(Math
        .atan(Math.tan(Math.atan(Math.tan(Math.atan(Math.tan(Math.atan(Math.tan(Math.atan(123456789.123456789))))))))));
    return 0;
  }

  /*
   * @GET
   * 
   * @Produces(MediaType.APPLICATION_JSON)
   * public List getAll() {
   * return List.of(new Item(1L, "Item1"), new Item(2L, "Item2"));
   * }
   */
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response getAllItems(@CookieParam(value = "cookieParam1") String cookieParam1,
      @CookieParam(value = "cookieParam2") String cookieParam2) {

    List items = List.of(new Item(1L, "Item1"), new Item(2L, "Item2"));

    foo();

    return Response.ok().entity(items)
        .cookie(new NewCookie("key1", "value1"))
        .cookie(new NewCookie("key2", "value2"))
        .build();
  }
}