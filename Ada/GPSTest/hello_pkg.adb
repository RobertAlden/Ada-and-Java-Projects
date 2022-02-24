with Ada.Text_IO; use Ada.Text_IO;
package body Hello_Pkg is
   procedure Hello (Item : in Integer) is
   begin
      Put_Line("Hello from Ada: " & Integer'Image(Item));
   end Hello;
end Hello_Pkg;
