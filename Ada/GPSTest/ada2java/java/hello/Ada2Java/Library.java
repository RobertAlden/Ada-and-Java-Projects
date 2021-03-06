/*****************************************************************************
 * This file has been automatically generated by                             *
 *    ADA2JAVA (built with ASIS 2.0.R for GNAT Pro 17.0 (20161010))          *
 * Original Ada unit: Ada2Java                                               *
 * Generation timestamp: 202202111029                                        *
 *****************************************************************************/

package hello.Ada2Java;

/**
 */
@SuppressWarnings("all")
public final class Library {
   public static final com.adacore.ajis.ILock lock = new com.adacore.ajis.DefaultLock ();
   private static boolean fLoaded = false;

   private static native void startLibrary ();

   public static void load () {
      if (!fLoaded) {
         fLoaded = true;
         com.adacore.ajis.AJISLibrary.load ();
         System.loadLibrary ("hello_proj");
         startLibrary ();
      }
   }

   static {
      hello.Ada2Java.Library Id_JNI_316;
      hello.Ada.Exceptions.Exception_Occurrence Id_JNI_317;
      hello.Hello_Pkg.Hello_Pkg_Package Id_JNI_318;
      hello.Standard.AdaString Id_JNI_319;
      hello.Standard.Constraint_Error Id_JNI_320;
      hello.Standard.Program_Error Id_JNI_321;
      hello.Standard.Storage_Error Id_JNI_322;
   }

   static {
      hello.Ada2Java.Library.load ();
   }

} // Library
