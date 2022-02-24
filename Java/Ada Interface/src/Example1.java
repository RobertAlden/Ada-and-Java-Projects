public class Example1 {
   native static int sum (int a, int b);
   public static void main (String[] args) {
      System.out.println (sum (10, 20));
   }
   static {
      System.loadLibrary ("Example1_Pkg");
   }
}