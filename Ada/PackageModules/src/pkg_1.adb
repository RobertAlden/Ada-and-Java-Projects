with Ada.Text_IO;
package body Pkg_1 is
   procedure Print(Input : Integer) is
   begin
      Ada.Text_IO.Put_Line(Integer'Image(Input));
   end Print;
end Pkg_1;
