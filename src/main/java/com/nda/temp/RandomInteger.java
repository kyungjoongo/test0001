package com.nda.temp;

import java.util.Random;

/** Generate 10 random integers in the range 0..99. */
public final class RandomInteger {
  
  public static final void main(String... aArgs){

    
    //note a single Random object is reused here
    Random randomGenerator = new Random();
    int randomInt = randomGenerator.nextInt(100000);
    System.out.println(randomInt);


  }
  
  private static void log(String aMessage){
    System.out.println(aMessage);
  }
}