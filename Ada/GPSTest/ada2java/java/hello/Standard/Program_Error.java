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
public final class Program_Error extends com.adacore.ajis.NativeException implements com.adacore.ajis.internal.ada.AdaException {

   hello.Ada.Exceptions.Exception_Occurrence Id_JNI_268;

   private Program_Error (String message, int [] addr) {
      super (message);
      Id_JNI_268 = new hello.Ada.Exceptions.Exception_Occurrence (new com.adacore.ajis.internal.ada.AdaAccess (addr));
      Id_JNI_268.myAllocator = com.adacore.ajis.IProxy.Allocator.DYNAMIC;
      Id_JNI_268.myOwner = com.adacore.ajis.IProxy.Owner.PROXY;
   }

   public Program_Error (hello.Standard.AdaString message) {
      super (message.toString());
      Id_JNI_268 = createOccurrence (message);
   }

   public int [] getExceptionAddr () {
      return Id_JNI_268.getAccess ();
   }

   /**
    * @param Message is passed by value
    * @return is passed by reference (escapable)
    */
   static public hello.Ada.Exceptions.Exception_Occurrence createOccurrence (hello.Standard.AdaString Message) {
      hello.Ada2Java.Library.lock.lock ();
      try {
         hello.Standard.AdaString Id_JNI_271 = Message;
         if (Id_JNI_271 == null) {
            throw new com.adacore.ajis.NativeException ("null not allowed for Message");
         }
         int [] Id_JNI_278;
         hello.Standard.AdaString Id_JNI_279 = Id_JNI_271;
         Id_JNI_278 = ((com.adacore.ajis.internal.ada.AdaProxy) Id_JNI_279).getAccess ();
         int [] Id_JNI_284 = createOccurrence_Id_JNI_269 (Id_JNI_278);
         hello.Ada.Exceptions.Exception_Occurrence Id_JNI_285;
         if (com.adacore.ajis.internal.ada.AdaAccess.isNull (Id_JNI_284)) {
            Id_JNI_285 = null;
         } else {
            Id_JNI_285 = new hello.Ada.Exceptions.Exception_Occurrence (new com.adacore.ajis.internal.ada.AdaAccess (Id_JNI_284));
         }
         hello.Ada.Exceptions.Exception_Occurrence Id_JNI_286 = Id_JNI_285;
         if (Id_JNI_286 != null) {
            Id_JNI_286.myAllocator = com.adacore.ajis.IProxy.Allocator.DYNAMIC;
         }
         hello.Ada.Exceptions.Exception_Occurrence Id_JNI_289 = Id_JNI_286;
         return Id_JNI_289;
      } finally {
         hello.Ada2Java.Library.lock.unlock ();
      }
   } // createOccurrence

   native static private int [] createOccurrence_Id_JNI_269 (int [] Message);

   static {
      hello.Ada2Java.Library.load ();
   }

} // Program_Error
