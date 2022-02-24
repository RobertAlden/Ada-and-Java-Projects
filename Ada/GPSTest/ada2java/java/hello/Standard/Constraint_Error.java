/*****************************************************************************
 * This file has been automatically generated by                             *
 *    ADA2JAVA (built with ASIS 2.0.R for GNAT Pro 17.0 (20161010))          *
 * Original Ada unit: Standard                                               *
 * Generation timestamp: 202202111029                                        *
 *****************************************************************************/

package hello.Standard;

/**
 */
@SuppressWarnings("all")
public final class Constraint_Error extends com.adacore.ajis.NativeException implements com.adacore.ajis.internal.ada.AdaException {

   hello.Ada.Exceptions.Exception_Occurrence Id_JNI_244;

   private Constraint_Error (String message, int [] addr) {
      super (message);
      Id_JNI_244 = new hello.Ada.Exceptions.Exception_Occurrence (new com.adacore.ajis.internal.ada.AdaAccess (addr));
      Id_JNI_244.myAllocator = com.adacore.ajis.IProxy.Allocator.DYNAMIC;
      Id_JNI_244.myOwner = com.adacore.ajis.IProxy.Owner.PROXY;
   }

   public Constraint_Error (hello.Standard.AdaString message) {
      super (message.toString());
      Id_JNI_244 = createOccurrence (message);
   }

   public int [] getExceptionAddr () {
      return Id_JNI_244.getAccess ();
   }

   /**
    * @param Message is passed by value
    * @return is passed by reference (escapable)
    */
   static public hello.Ada.Exceptions.Exception_Occurrence createOccurrence (hello.Standard.AdaString Message) {
      hello.Ada2Java.Library.lock.lock ();
      try {
         hello.Standard.AdaString Id_JNI_247 = Message;
         if (Id_JNI_247 == null) {
            throw new com.adacore.ajis.NativeException ("null not allowed for Message");
         }
         int [] Id_JNI_254;
         hello.Standard.AdaString Id_JNI_255 = Id_JNI_247;
         Id_JNI_254 = ((com.adacore.ajis.internal.ada.AdaProxy) Id_JNI_255).getAccess ();
         int [] Id_JNI_260 = createOccurrence_Id_JNI_245 (Id_JNI_254);
         hello.Ada.Exceptions.Exception_Occurrence Id_JNI_261;
         if (com.adacore.ajis.internal.ada.AdaAccess.isNull (Id_JNI_260)) {
            Id_JNI_261 = null;
         } else {
            Id_JNI_261 = new hello.Ada.Exceptions.Exception_Occurrence (new com.adacore.ajis.internal.ada.AdaAccess (Id_JNI_260));
         }
         hello.Ada.Exceptions.Exception_Occurrence Id_JNI_262 = Id_JNI_261;
         if (Id_JNI_262 != null) {
            Id_JNI_262.myAllocator = com.adacore.ajis.IProxy.Allocator.DYNAMIC;
         }
         hello.Ada.Exceptions.Exception_Occurrence Id_JNI_265 = Id_JNI_262;
         return Id_JNI_265;
      } finally {
         hello.Ada2Java.Library.lock.unlock ();
      }
   } // createOccurrence

   native static private int [] createOccurrence_Id_JNI_245 (int [] Message);

   static {
      hello.Ada2Java.Library.load ();
   }

} // Constraint_Error